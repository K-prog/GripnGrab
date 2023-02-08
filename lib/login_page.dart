import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'otp.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? mobile_number = ""; //Defining the variable
  var phone = "";
  static String verify = "";
  LoginPage({super.key});
  final TextEditingController phone_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    phone_controller.selection = TextSelection.fromPosition(
        TextPosition(offset: phone_controller.text.length));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: null, //Removing the appbar
        body: SafeArea(
            child: SingleChildScrollView(
          //Making the body scrollable
          child: Container(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
            color: Color(0xFF1C1C1E), //Setting the background color
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/loginimg.png',
                    width: double.infinity,
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      onChanged: (value) => phone = value,
                      style: TextStyle(
                          color: Colors.white),
                      keyboardType:
                          TextInputType.phone, //Defining the keyboard type
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'[0-9]')), //Defining the input format, i.e. only numbers
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (input) {
                        if (input!.length < 10) {
                          return 'Please enter a 10 digit number';
                        }
                        return null;
                      },
                      onSaved: (input) => mobile_number = input,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(
                            color: Colors.white), //Setting the text color
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.white,
                          ), //Setting the border color
                        ),
                      ),
                    ),
                  ),
                  // ScaffoldMessenger.of(phone).showSnackBar(
                  //   const SnackBar(
                  //     content: Text(phone),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${'+91' + phone}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            LoginPage.verify = verificationId;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpPage(),
                          ),
                        );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          ; //Printing the mobile number
                          // Navigator.pushNamed(context, 'otp');
                        }
                      },
                      child: const Text(
                        'Get OTP',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
