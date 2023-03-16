import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/models/app_model.dart';
import 'package:gripngrab/models/user_model.dart';
import 'package:gripngrab/providers/sessions_provider.dart';
import 'package:gripngrab/screens/auth/otp_screen.dart';
import 'package:gripngrab/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String docId = "";
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String? get uid => _uid;
  bool _morningBooked = false;
  bool get morningBooked => _morningBooked;
  bool _eveningBooked = false;
  bool get eveningBooked => _eveningBooked;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  File? _selectedUserImage;
  File? get selectedUserImage => _selectedUserImage;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String? _verificationId;
  String? get verificationId => _verificationId;

  AuthProvider() {
    checkSignIn();
    getDocId();
  }
  set settinguserModel(UserModel? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  set verificationCode(String id) {
    _verificationId = id;
    notifyListeners();
  }

  set setCurrentImage(File? setimage) {
    _selectedUserImage = setimage;
    notifyListeners();
  }

  void setLoading({required bool isLoading}) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setUserModel() async {
    final SharedPreferences ss = await SharedPreferences.getInstance();
    _userModel = UserModel.fromJson(
      jsonDecode(ss.getString('userModel') ?? ''),
    );
    _eveningBooked = ss.getBool('eveningBooked') ?? false;
    _morningBooked = ss.getBool('morningBooked') ?? false;
    notifyListeners();
  }

  Future<void> getUserBookingStatus(
    SessionsProvider sessionsProvider,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collectionGroup('slots')
        .where('bookedBy', isEqualTo: userModel!.id)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      SessionBooked sessionBooked =
          SessionBooked.fromJson(querySnapshot.docs[0].data() as dynamic);
      DocumentSnapshot snapshot = await firebaseFirestore
          .collection('sessions')
          .doc(sessionBooked.timeFrameId)
          .get();

      if (snapshot.exists) {
        String currentType = snapshot['sessionType'];
        sessionsProvider.sessionId = snapshot['id'];
        if (currentType == 'morning') {
          _morningBooked = true;
          _eveningBooked = false;
          await sharedPreferences.setBool('morningBooked', true);
          await sharedPreferences.setBool('eveningBooked', false);
        } else {
          _morningBooked = false;
          _eveningBooked = true;
          await sharedPreferences.setBool('morningBooked', false);
          await sharedPreferences.setBool('eveningBooked', true);
        }
        notifyListeners();
      }
    }

    // updating user membership also
    await firebaseFirestore
        .collection('users')
        .doc(userModel!.id)
        .get()
        .then((value) {
      if (value.exists) {
        userModel!.membershipActivated = value['membershipActivated'];
        notifyListeners();
      }
    });
    await sharedPreferences.setString(
      'userModel',
      jsonEncode(
        _userModel!.toJson(),
      ),
    );
  }

  // sign in with phone
  Future<void> signInWithPhone({
    required BuildContext context,
    required String phoneNumber,
    bool resend = false,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential phoneAuthCreds) async {
            await firebaseAuth.signInWithCredential(phoneAuthCreds);
          },
          phoneNumber: phoneNumber,
          verificationFailed: (error) {
            if (error.message == 'TOO_LONG') {
              showSnackBar(
                context: context,
                content:
                    'Phone number is too long, please enter it in correct way.',
              );
            } else {
              showSnackBar(context: context, content: error.message.toString());
            }
          },
          codeSent: ((String verificationId, forceResendingToken) {
            _verificationId = verificationId;
            if (resend) {
              showSnackBar(
                context: context,
                content: 'Otp code resent to your phone number',
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OtpScreen(phoneNumber: phoneNumber),
                ),
              );
            }
          }),
          codeAutoRetrievalTimeout: (verificationId) {});
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      showSnackBar(context: context, content: e.message.toString());
      notifyListeners();
    }
  }

  // verify otp
  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp,
      required Function onSuccess}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );
      User user = (await firebaseAuth.signInWithCredential(credential)).user!;
      // setting up userId of sign in user
      _uid = user.uid;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        showSnackBar(
          context: context,
          content: 'Please enter correct otp send to your device.',
        );
        _isLoading = false;
        notifyListeners();
      } else {
        showSnackBar(context: context, content: e.message.toString());
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // save user data
  Future<void> saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
  }) async {
    try {
      String phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
      // saving user data to database
      await storeFileToFirebase('profilePic/$_uid', profilePic).then((value) {
        userModel.id = _uid!;
        userModel.phoneNumber = phoneNumber;
        userModel.profilePhoto = value;
      });
      // uploading the user data
      await firebaseFirestore
          .collection('users')
          .doc(_uid)
          .set(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      showSnackBar(context: context, content: e.message.toString());
      notifyListeners();
    }
  }

  // uploading image
  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // saving gender details
  Future<void> updateGender({
    required BuildContext context,
    required String gender,
  }) async {
    await firebaseFirestore.collection('users').doc(_uid).update({
      'gender': gender,
    });
  }

  // getting user data from firebase
  Future<void> getUserDataFromFirestore(String id) async {
    try {
      DocumentSnapshot snapshot =
          await firebaseFirestore.collection('users').doc(id).get();
      if (snapshot.exists) {
        _userModel = UserModel.fromJson(snapshot.data() as dynamic);
      }
      notifyListeners();
    } catch (e) {
      userSignOut();
      notifyListeners();
    }
  }

  // Future addUserDetails() async {
  //   final docId = await firebaseFirestore.collection("users").add({
  //     "phone": LoginPage.phone,
  //     "firstName": InputScreen.firstName,
  //     "lastName": InputScreen.lastName,
  //     "gender": GenderPage.gender,
  //     "dob": BirthdatePage.dob,
  //     "membershipStatus": "Inactive",
  //   });

  //   final SharedPreferences s = await SharedPreferences.getInstance();
  //   s.setString("docId", docId.id);
  //   this.docId = docId.id;
  //   notifyListeners();
  // }
  Future saveDataToSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      'userModel',
      jsonEncode(
        _userModel!.toJson(),
      ),
    );
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("isSignedIn") ?? false;

    notifyListeners();
  }

  // session related concept
  Future<void> updateUserBookingStatus(
      {required SessionType sessionType, bool isCanceled = false}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isCanceled) {
      await sharedPreferences.setBool('morningBooked', false);
      await sharedPreferences.setBool('eveningBooked', false);
      _morningBooked = false;
      _eveningBooked = false;
      notifyListeners();
    } else {
      if (sessionType == SessionType.morning) {
        await sharedPreferences.setBool('morningBooked', true);
        await sharedPreferences.setBool('eveningBooked', false);
        _morningBooked = true;
        _eveningBooked = false;
        notifyListeners();
      } else {
        await sharedPreferences.setBool('eveningBooked', true);
        await sharedPreferences.setBool('morningBooked', false);
        _eveningBooked = true;
        _morningBooked = false;
        notifyListeners();
      }
    }
  }

  void setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("isSignedIn", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void setMembershipStatus(bool status) async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("isMember", status);
    notifyListeners();
  }

  Future<bool> getMembershipStatus() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    bool status = s.getBool("isMember") ?? false;
    notifyListeners();
    return status;
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection('users').doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getDocId() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    docId = (s.getString("docId")) ?? '';
    notifyListeners();
    return docId;
    // notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await firebaseAuth.signOut();
    _isSignedIn = false;
    await s.clear();
    notifyListeners();
  }

  // Future<String> getDataFromFirestore(String s) async {
  //   QuerySnapshot snapshot = await _firebaseFirestore
  //       .collection("users")
  //       .where("phone", isEqualTo: LoginPage.phone)
  //       .get();
  //   if (snapshot.docs.isNotEmpty) {
  //     Map<String, dynamic> data =
  //         snapshot.docs[0].data() as Map<String, dynamic>;
  //     print(data[s]);
  //     return data[s] as String;
  //   } else {
  //     return "";
  //   }
  // }
}
