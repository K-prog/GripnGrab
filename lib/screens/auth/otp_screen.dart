import 'package:flutter/material.dart';
import 'package:gripngrab/screens/auth/user_name_screen.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otp;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: null,
        body: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                const Text(
                  "Verification",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "We've sent you the OTP at your phone number.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  onChanged: (value) {
                    if (value.length == 6) {
                      setState(() {
                        otp = value;
                      });
                    } else {
                      setState(() {
                        otp = null;
                      });
                    }
                  },
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(234, 239, 243, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledBackgroundColor: Colors.white30,
                      disabledForegroundColor: Colors.black54,
                    ),
                    onPressed: otp != null
                        ? () => verifyOtp(context: context, userOtp: otp!)
                        : null,
                    // onPressed: () async {
                    //   try {
                    //     PhoneAuthCredential credential =
                    //         PhoneAuthProvider.credential(
                    //             verificationId: LoginPage.verify,
                    //             smsCode: code);

                    //     // Sign the user in (or link) with the credential
                    //     User? user =
                    //         (await auth.signInWithCredential(credential))
                    //             .user;
                    //     if (user != null) {
                    //       String _uid = user.uid;
                    //       print(ap.checkExistingUser());
                    //       ap.checkExistingUser().then((value) async {
                    //         if (value) {
                    //           ap
                    //               .getDataFromFirestore("membershipStatus")
                    //               .then((status) async {
                    //             if (status.toLowerCase() == "inactive") {
                    //               ap.setMembershipStatus(false);
                    //             } else if (status.toLowerCase() == "active") {
                    //               ap.setMembershipStatus(true);
                    //             } else {
                    //               ap.setMembershipStatus(false);
                    //               // Toast unable to fetch membership status
                    //             }
                    //           });
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => LandingPage(),
                    //             ),
                    //           );
                    //         } else {
                    //           ap.setMembershipStatus(false);
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => InputScreen(),
                    //             ),
                    //           );
                    //         }
                    //       });
                    //     }
                    //   } catch (e) {
                    //     var snackBar = SnackBar(
                    //         content: Text('Wrong OTP',
                    //             style: TextStyle(
                    //                 fontFamily: 'Montserrat',
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.bold)));
                    //     // Step 3
                    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   }
                    // },
                    child: authProvider.isLoading == true
                        ? Container(
                            height: 25,
                            alignment: Alignment.center,
                            width: 25,
                            child: const CircularProgressIndicator(
                              color: kPrimaryColor,
                              strokeWidth: 3.0,
                            ),
                          )
                        : const Text("Verify Phone Number"),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyOtp(
      {required BuildContext context, required String userOtp}) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.setLoading(isLoading: true);
    authProvider.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () async {
        await authProvider.checkExistingUser().then((value) async {
          if (value == true) {
          } else {
            authProvider.setLoading(isLoading: false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserNameScreen(),
              ),
            );
          }
        });
      },
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
