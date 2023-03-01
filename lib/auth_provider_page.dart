// import 'dart:html';
import 'dart:async';

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
      "membershipStatus": "Inactive",
    });
    
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setString("docId", docId.id);
    this.docId=docId.id;
    notifyListeners();
  }

  Future<bool> checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("isSignedIn") ?? false;
    notifyListeners();
    return _isSignedIn;
  }

  void setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("isSignedIn", true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future<bool> checkExistingUser() async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection("users").where("phone", isEqualTo: LoginPage.phone).get();
    if (snapshot.docs.isNotEmpty) {
      final SharedPreferences s = await SharedPreferences.getInstance();
      this.docId = snapshot.docs[0].id;
      notifyListeners();
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }
  Future<String> getDocId() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    docId= (s.getString("docId") ?? null)!;
    notifyListeners();
    return docId;
    // notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    s.clear();
    notifyListeners();

  }
  

Future getDataFromFirestore() async { 
  await _firebaseFirestore
.collection("users")
.where("phone", isEqualTo: LoginPage.phone)
.get()
.then((DocumentSnapshot snapshot) { 
  print (snapshot["phone"]);
} as FutureOr Function(QuerySnapshot<Map<String, dynamic>> value));
} 
}
