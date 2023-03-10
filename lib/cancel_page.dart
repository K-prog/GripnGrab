import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/gender.dart';
import 'package:gripngrab/thanks_page.dart';
import 'package:provider/provider.dart';
import 'package:gripngrab/landing_page.dart';

import 'auth_provider_page.dart';

class CancelPage extends StatefulWidget {
  @override
  _CancelPage createState() => _CancelPage();
}

class _CancelPage extends State<CancelPage> {
  Future openDialog(String sessionTime) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              sessionTime,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF2C2C2E),
            actionsAlignment: MainAxisAlignment.center,
            // content: Text("This slot is already booked"),
            actions: [
              ElevatedButton(
                child: Text("Book a session"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThanksScreen(),
                    ),
                  );
                },
              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  @override
  Widget build(BuildContext context) {
  // Timer(
  //       const Duration(milliseconds: 2500),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => LandingPage())));
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference users =
        FirebaseFirestore.instance.collection('morningSession');
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      extendBodyBehindAppBar: true,
      appBar: null,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder<DocumentSnapshot>(
            future: users.doc("lDKjgkrC3v8rrkd6MmQQ").get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children:[
                      // Container(
                      //   // padding: EdgeInsets.only(right: 20.0),
                      // height: 30.0,
                      // width: 30.0,
                      // child: InkWell(
                      // child: Image.asset("assets/images/cancel.png"),
                      // onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => LandingPage(),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // ),
                      //   ],
                      // ),
                      SizedBox(height: 40),
                      Text("Session Cancelled",
                          style: TextStyle(
                              color: Color(0xFFBACBD3),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w800,
                              fontSize: 40)),
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/images/sad.gif',
                        width: double.infinity,
                      ),
                      SizedBox(height: 140),
                        Text("We will miss you today!",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w100,
                                fontSize: 20)),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                color: Color(0xFF1C1C1E),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandingPage(),
                              ),
                            );
                          },
                        ),
                      // FittedBox(
                      //   child: Image.asset('assets/vids/final_intro.gif'),
                      // ),
                    ],
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
    ),);
  }
}
