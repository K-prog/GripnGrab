import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/models/user_model.dart';
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
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  AuthProvider() {
    checkSignIn();
    getDocId();
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
    notifyListeners();
  }

  // sign in with phone
  Future<void> signInWithPhone({
    required BuildContext context,
    required String phoneNumber,
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
                      'Phone number is too long, please enter it in correct way.');
            }
          },
          codeSent: ((String verificationId, forceResendingToken) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ),
            );
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
      _isLoading = false;
      showSnackBar(context: context, content: e.message.toString());
      notifyListeners();
    }
  }

  // save user data
  void saveUserDataToFirebase(
      {required BuildContext context,
      required UserModel userModel,
      required File profilePic,
      required Function onSuccess}) async {
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
          .set(userModel.toJson())
          .then((value) {
        _isLoading = false;
        notifyListeners();
        onSuccess();
      });
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
    await firebaseAuth.setSettings(appVerificationDisabledForTesting: true);
    notifyListeners();
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
    s.clear();
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
