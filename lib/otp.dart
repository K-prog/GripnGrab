import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/birth_page.dart';
import 'package:gripngrab/landing_page.dart';
import 'package:gripngrab/name_page.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'auth_provider_page.dart';
import 'gender.dart';
import 'login_page.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpKey = GlobalKey<FormState>();
  late String _otp;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final ap= Provider.of<AuthProvider>(context, listen: false);
    // final isloading = Provider.of<AuthProvider>(context, listen: false);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: null,
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "Verification",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We've sent you the OTP at your phone number.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: LoginPage.verify,
                                smsCode: code);

                        // Sign the user in (or link) with the credential
                        User ? user = (await auth.signInWithCredential(credential)).user;
                        if (user!=null){
                            String _uid = user.uid;
                            ap.checkExistingUser(_uid).then((value) async {
                              if (value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LandingPage(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InputScreen(),
                                  ),
                                );
                              }
                            });
                        }
                      } catch (e) {
                        var snackBar =
                            SnackBar(content: Text('Wrong OTP' , style: TextStyle(fontFamily: 'Montserrat', fontSize: 15,fontWeight: FontWeight.bold )));
                        // Step 3
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        ); //Printing the mobile number
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pinput/pinput.dart';

// import 'gender.dart';
// import 'login_page.dart';

// class OtpPage extends StatefulWidget {
//   @override
//   _OtpPageState createState() => _OtpPageState();
// }


// class _OtpPageState extends State<OtpPage> {
//   bool countDownComplete = false;
//   int currentSeconds = 0;
//   int timerMaxSeconds = 30;
//   String get timerText =>
//       '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
//   final interval = const Duration(seconds: 1);
//   startTimeout([int? milliseconds]) {
//     var duration = interval;
//     Timer.periodic(duration, (timer) {
//       setState(() {
//         // print(timer.tick);
//         currentSeconds = timer.tick;
//         if (timer.tick >= timerMaxSeconds) {
//           setState(() {
//             countDownComplete = true;
//           });
//           timer.cancel();
//         }
//       });
//     });
//   }

//   @override
//   void initState() {
//     startTimeout();
//     super.initState();
//   }
//   final otpKey = GlobalKey<FormState>();
//   late String _otp;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );

//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
//       borderRadius: BorderRadius.circular(8),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );
//     var code = "";
//     return Scaffold(
//       backgroundColor: Color(0xFF1C1C1E),
//       appBar: null,
//       body: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 25,
//               ),
//               Text(
//                 "Verification",
//                 style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "We've sent you the OTP at your phone number.",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Pinput(
//                 length: 6,
//                 onChanged: (value) {
//                   code = value;
//                 },
//                 // defaultPinTheme: defaultPinTheme,
//                 // focusedPinTheme: focusedPinTheme,
//                 // submittedPinTheme: submittedPinTheme,

//                 showCursor: true,
//                 onCompleted: (pin) => print(pin),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () async {
//                       try {
//                           PhoneAuthCredential credential =
//                             PhoneAuthProvider.credential(
//                                 verificationId: LoginPage.verify,
//                                 smsCode: code);

//                         // Sign the user in (or link) with the credential
//                         await auth.signInWithCredential(credential);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => GenderPage(),
//                           ),
//                         );
//                       //   PhoneAuthCredential credential =
//                       //       PhoneAuthProvider.credential(
//                       //           verificationId: LoginPage.verify,
//                       //           smsCode: code);

//                       //   // Sign the user in (or link) with the credential
//                       //   await auth.signInWithCredential(credential);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => GenderPage(),
//                       //   ),
//                       // );
//                       } catch (e) {
//                         // _showFlashMessage(BuildContext context) {
                          
//                         //   Scaffold.of(context).showSnackBar(
//                         //     SnackBar(
//                         //       content: Text('This is a flash message'),
//                         //       duration: Duration(seconds: 3),
//                         //       action: SnackBarAction(
//                         //         label: 'Dismiss',
//                         //         onPressed: () {
//                         //           Scaffold.of(context).hideCurrentSnackBar();
//                         //         },
//                         //       ),
//                         //     ),
//                         //   );
//                         // }
//                       }
//                     },
//                     child: Text("Verify Phone Number")),
//               ),
//                             SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () async {
//                       //print(timerText);
//                       if (countDownComplete) {
//                         // print("ggg");
//                         //  await FirebaseAuth.instance.verifyPhoneNumber(
//                         //   phoneNumber: '${'+91' + LoginPage.phone}',
//                         //   verificationCompleted:
//                         //       (PhoneAuthCredential credential) {},
//                         //   verificationFailed: (FirebaseAuthException e) {},
//                         //   codeSent: (String verificationId, int? resendToken) {
//                         //     LoginPage.verify = verificationId;
//                         //   },
//                         //   codeAutoRetrievalTimeout: (String verificationId) {},
//                         // );
//                         // countDownComplete = false;
//                         // startTimeout();
//                         //execute code
//                       } //else do nothing
//                     },
//                     child: timerText == "00: 00"
//                         ? Text("Resend OTP ")
//                         : Text("Resend OTP " + timerText)),
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LoginPage(),
//                           ),
//                         ); //Printing the mobile number
//                       },
//                       child: Text(
//                         "Edit Phone Number ?",
//                         style: TextStyle(color: Colors.white),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
    
//   }
// }
