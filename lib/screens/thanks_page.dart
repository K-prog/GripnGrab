import 'package:flutter/material.dart';
import 'package:gripngrab/screens/mybottom_bar.dart';

class ThanksScreen extends StatefulWidget {
  const ThanksScreen({super.key});

  @override
  State<ThanksScreen> createState() => _ThanksScreen();
}

class _ThanksScreen extends State<ThanksScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1C1E),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Thank you",
                  style: TextStyle(
                      color: Color(0xFFBACBD3),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 40)),
              const SizedBox(height: 20),
              const Text("Your session is booked",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/happy.gif',
                width: double.infinity,
              ),
              const SizedBox(height: 140),
              const Text(
                "See you at the arena champ!",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w100,
                    fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
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
              // FittedBox(
              //   child: Image.asset('assets/vids/final_intro.gif'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
