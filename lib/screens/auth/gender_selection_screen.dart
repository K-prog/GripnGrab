import 'package:flutter/material.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/screens/auth/birth_page.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:provider/provider.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});
  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  late AuthProvider authProvider;
  void selectGender(bool isMale) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.userModel!.gender = isMale ? 'male' : 'female';
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BirthdatePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Tell us about yourself!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'To give you a better experience we need',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              const Text(
                'to know your gender',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => selectGender(true),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: Column(
                  children: const [
                    Icon(
                      Icons.male,
                      color: Color.fromRGBO(234, 239, 243, 1),
                      size: 94,
                    ),
                    Text(
                      "Male",
                      style: TextStyle(
                        color: Color.fromRGBO(234, 239, 243, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => selectGender(false),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: Column(
                  children: const [
                    Icon(
                      Icons.female,
                      color: Color.fromRGBO(234, 239, 243, 1),
                      size: 94,
                    ),
                    Text(
                      "Female",
                      style: TextStyle(
                        color: Color.fromRGBO(234, 239, 243, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
