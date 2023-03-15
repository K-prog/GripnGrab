import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/providers/sessions_provider.dart';
import 'package:gripngrab/screens/auth/login_page.dart';
import 'package:gripngrab/screens/mybottom_bar.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthProvider authProvider;
  late SessionsProvider sessionsProvider;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    sessionsProvider = Provider.of<SessionsProvider>(context, listen: false);
    Timer(const Duration(milliseconds: 5000), () {
      if (authProvider.isSignedIn) {
        authProvider.setUserModel();
        sessionsProvider.setSessionId();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyBottomBar(selectedIndex: 0),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/vids/final_intro.gif',
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
