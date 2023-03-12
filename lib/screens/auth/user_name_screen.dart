import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gripngrab/models/user_model.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/screens/auth/gender_selection_screen.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:gripngrab/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? image;
  late AuthProvider authProvider;

  selectImage() async {
    image = await pickImageFromGallery(context, ImageSource.gallery);
    setState(() {});
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  // store user data
  void storeUserData() async {
    DateTime timeStamp = DateTime.now();
    if (image != null) {
      UserModel userModel = UserModel(
        id: '',
        phoneNumber: '',
        createdAt: timeStamp,
        profilePhoto: '',
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: '',
        dateOfBirth: _dateOfBirthController.text.trim(),
        membershipActivated: false,
      );
      authProvider.setLoading(isLoading: true);
      authProvider.saveUserDataToFirebase(
          context: context,
          userModel: userModel,
          profilePic: image!,
          onSuccess: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GenderSelectionScreen(),
              ),
            );
          });
    } else {
      showSnackBar(
        context: context,
        content:
            'Profile photo is required for creating your account with GripnGrab',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: null,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40.0),
                  InkWell(
                    onTap: selectImage,
                    child: image == null
                        ? const CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(image!),
                          ),
                  ),
                  const SizedBox(height: 30.0),
                  TextField(
                    controller: _firstNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.white60),
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                      ),
                      hintText: 'Enter your first name',
                      hintStyle: TextStyle(color: Colors.white60),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ), //Setting the border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ), //Setting the border color
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ), //Setting the border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _lastNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white60),
                      hintText: 'Enter your last name',
                      hintStyle: TextStyle(color: Colors.white60),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ), //Setting the border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ), //Setting the border color
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ), //Setting the border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // date of birth selector
                  TextField(
                    controller: _dateOfBirthController,
                    onTap: () async {
                      // Show the date picker
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: kPrimaryColor,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: Colors.black,
                                ),
                              ),
                              child: child!);
                        },
                      );

                      // Update the text field value with the selected date
                      if (selectedDate != null) {
                        _dateOfBirthController.text =
                            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Date Of Birth',
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white60),
                      hintStyle: TextStyle(color: Colors.white60),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ), //Setting the border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ), //Setting the border color
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ), //Setting the border color
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: storeUserData,
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
                          : const Text(
                              'Submit',
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
