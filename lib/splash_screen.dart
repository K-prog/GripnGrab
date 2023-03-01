import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider_page.dart';
import 'landing_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    Timer(
        const Duration(milliseconds: 5000),
        () => Navigator.of(context).pushReplacement(ap.isSignedIn == true
            ? MaterialPageRoute(
                builder: (BuildContext context) => LandingPage())
            : MaterialPageRoute(
                builder: (BuildContext context) => LoginPage())));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Image.asset('assets/vids/final_intro.gif'),
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}