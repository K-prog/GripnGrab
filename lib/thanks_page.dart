import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider_page.dart';
import 'landing_page.dart';
import 'login_page.dart';

class ThanksScreen extends StatefulWidget {
  @override
  _ThanksScreen createState() => _ThanksScreen();
}
class _ThanksScreen extends State<ThanksScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(milliseconds: 2500),
        () => Navigator.of(context).pushReplacement( MaterialPageRoute(
                builder: (BuildContext context) => LandingPage())));
    return WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Thank you",
                style: TextStyle(
                   color: Color(0xFFBACBD3),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    fontSize: 40)),
                    SizedBox(height: 20),
                     Text("Your session is booked",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    fontSize: 20)),
                    SizedBox(height: 20),
                    Image.asset(
              'assets/images/happy.gif',
              width: double.infinity,
            ),
            SizedBox(height: 140),
            Text("See you at the arena champ!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w100,
                      fontSize: 20)),
              SizedBox(height: 20),
            // FittedBox(
            //   child: Image.asset('assets/vids/final_intro.gif'),
            // ),
          ],
        ),
      ),
    ),);
  }
}
