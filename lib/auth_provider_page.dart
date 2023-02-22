// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/gender.dart';
import 'package:gripngrab/login_page.dart';
import 'package:gripngrab/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'birth_page.dart';
import 'name_page.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  String docId="";
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool get isSignedIn => _isSignedIn;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  AuthProvider() {
    checkSignIn();
    getDocId();
  }
  Future addUserDetails() async {
    final docId = await firebaseFirestore.collection("users").add({
      "phone": LoginPage.phone,
      "firstName": InputScreen.firstName,
      "lastName": InputScreen.lastName,
      "gender": GenderPage.gender,
      "dob": BirthdatePage.dob,
    });

    // Future<void> _getUserName() async {
    //       Firestore.instance
    //           .collection('Users')
    //           .document((await FirebaseAuth.instance.currentUser()).uid)
    //           .get()
    //           .then((value) {
    //         setState(() {
    //           _userName = value.data['UserName'].toString();
    //         });
    //       });
    //     }
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setString("docId", docId.id);
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("isSignedIn") ?? false;
    notifyListeners();
  }

  void setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("isSignedIn", true);
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {} on FirebaseAuthException catch (e) {}
  }

  Future<bool> checkExistingUser(String _uid) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  // Future getUserData(String documentId) async {
  //   CollectionReference users = firebaseFirestore.collection('users');

  //   return FutureBuilder<DocumentSnapshot>(
  //     future: users.doc(documentId).get(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text("Something went wrong");
  //       }

  //       if (snapshot.hasData && !snapshot.data!.exists) {
  //         return Text("Document does not exist");
  //       }

  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data =
  //             snapshot.data!.data() as Map<String, dynamic>;
  //         return Text("Full Name: ${data['firstName']} ${data['lastName']}");
  //       }

  //       return Text("loading");
  //     },
  //   );
  // }
  Future<Map<String, dynamic>?> getUserData(String documentId) async {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    final documentSnapshot = await usersCollection.doc(documentId).get();
    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }
  void getDocId() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    docId= (s.getString("docId") ?? null)!;
    notifyListeners();
    // notifyListeners();
  }
// void saveUserDataToFirebase({
//   required BuildContext context,
//   required UserModel userModel,
//   required File profilePic,
//   required Function onSuccess,
// }) async {
// // _isLoading = true;
// notifyListeners();
// try {
// // uploading image to firebase storage.
// await storeFileToStorage ("profilePic/", profilePic).then((value)
// { userModel.name = value;
// userModel.createdAt = DateTime.now(). millisecondsSinceEpoch.toString();
// userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
// userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
// });
// } on FirebaseAuthException catch (e) {
// // showSnackBar(context, e.message.toString());
// // _isLoading = false;
// notifyListeners();
//  }
// }

// Future<String> storeFileToStorage (String ref, File file) async {
// UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
// TaskSnapshot snapshot = await uploadTask;
// String downloadUrl = await snapshot.ref.getDownloadURL();
// return downloadUrl;
// }
}
