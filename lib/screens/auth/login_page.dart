import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:gripngrab/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  late AuthProvider authProvider;
  final ImageProvider loginImage = const AssetImage(
    'assets/images/loginimg.png',
  );

  void precacheBackground() {
    precacheImage(loginImage, context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      precacheBackground();
    });
  }

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    authProvider = Provider.of<AuthProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async => false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: null,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: (MediaQuery.of(context).size.height),
                    width: (MediaQuery.of(context).size.width),
                    color: kPrimaryColor, //Setting the background color
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: loginImage,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  phoneController.text = value;
                                });
                              },
                              maxLengthEnforcement: MaxLengthEnforcement.none,
                              maxLength: 10,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType
                                  .phone, //Defining the keyboard type
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
                              decoration: const InputDecoration(
                                counterText: '',
                                labelText: 'Mobile Number',
                                labelStyle: TextStyle(
                                    color:
                                        Colors.white), //Setting the text color
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                  ), //Setting the border color
                                ),
                                filled: false,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                  ), //Setting the border color
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.red,
                                  ), //Setting the border color
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (phoneController.text.isNotEmpty &&
                                    phoneController.text.length == 10) {
                                  sendPhoneNumber();
                                } else {
                                  showSnackBar(
                                      context: context,
                                      content:
                                          'Phone number should be of 10 digits');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder()),
                              child: authProvider.isLoading
                                  ? Container(
                                      height: 25,
                                      alignment: Alignment.center,
                                      width: 25,
                                      child: const CircularProgressIndicator(
                                        color: kPrimaryColor,
                                        strokeWidth: 3.0,
                                      ),
                                    )
                                  : const Text(
                                      'Get OTP',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    padding: const EdgeInsets.only(bottom: 5),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        letterSpacing: 1.2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  // sending phone number
  void sendPhoneNumber() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    authProvider.setLoading(isLoading: true);
    await authProvider.signInWithPhone(
      context: context,
      phoneNumber: "+91$phoneNumber",
    );
  }
}
