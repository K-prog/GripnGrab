import 'package:flutter/material.dart';
import 'package:gripngrab/screens/landing_page.dart';
import 'package:gripngrab/screens/mybottom_bar.dart';

class CancelPage extends StatefulWidget {
  const CancelPage({super.key});

  @override
  State<CancelPage> createState() => _CancelPage();
}

class _CancelPage extends State<CancelPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1C1E),
        extendBodyBehindAppBar: true,
        appBar: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text("Session Cancelled",
                style: TextStyle(
                    color: Color(0xFFBACBD3),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    fontSize: 40)),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/sad.gif',
              width: double.infinity,
            ),
            const SizedBox(height: 140),
            const Text("We will miss you today!",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w100,
                    fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                "Continue",
                style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyBottomBar(selectedIndex: 0),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
