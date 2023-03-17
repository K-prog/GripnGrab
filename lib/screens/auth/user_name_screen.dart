import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gripngrab/models/user_model.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/screens/auth/gender_selection_screen.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:gripngrab/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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

  Future<void> checkImage() async {
    if (image == null) {
      ByteData imageData = await rootBundle.load('assets/images/avatar.png');
      Uint8List bytes = imageData.buffer.asUint8List();
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = '${tempDir.path}/temp_image.png';
      final File tempImage = File(tempPath);
      await tempImage.writeAsBytes(bytes);
      image = tempImage;
    }
  }

  // store user data
  void storeUserData() async {
    await checkImage().whenComplete(() {
      authProvider = Provider.of<AuthProvider>(context, listen: false);
      DateTime timeStamp = DateTime.now();
      authProvider.settinguserModel = UserModel(
        id: '',
        phoneNumber: '',
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        gender: '',
        createdAt: timeStamp,
        profilePhoto: '',
        dateOfBirth: '',
        membershipActivated: false,
      );
      authProvider.setCurrentImage = image;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GenderSelectionScreen(),
        ),
      );
    });

    // authProvider.saveUserDataToFirebase(
    //     context: context,
    //     userModel: userModel,
    //     profilePic: image!,
    //     onSuccess: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const GenderSelectionScreen(),
    //         ),
    //       );
    //     });
  }

  @override
  Widget build(BuildContext context) {
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
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.edit,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              )
                            ],
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
                  // TextField(
                  //   controller: _dateOfBirthController,
                  //   onTap: () async {
                  //     // Show the date picker
                  //     final DateTime? selectedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime(1900),
                  //       lastDate: DateTime.now(),
                  //       builder: (context, child) {
                  //         return Theme(
                  //             data: ThemeData.light().copyWith(
                  //               colorScheme: const ColorScheme.light(
                  //                 primary: kPrimaryColor,
                  //                 onPrimary: Colors.white,
                  //                 surface: Colors.white,
                  //                 onSurface: Colors.black,
                  //               ),
                  //             ),
                  //             child: child!);
                  //       },
                  //     );

                  //     // Update the text field value with the selected date
                  //     if (selectedDate != null) {
                  //       _dateOfBirthController.text =
                  //           "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                  //     }
                  //   },
                  //   style: const TextStyle(color: Colors.white),
                  //   decoration: const InputDecoration(
                  //     labelText: 'Date Of Birth',
                  //     prefixIcon: Icon(
                  //       Icons.calendar_month,
                  //       color: Colors.white,
                  //     ),
                  //     labelStyle: TextStyle(color: Colors.white60),
                  //     hintStyle: TextStyle(color: Colors.white60),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  //       borderSide: BorderSide(
                  //         width: 2,
                  //         color: Colors.white,
                  //       ), //Setting the border color
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  //       borderSide: BorderSide(
                  //         width: 2,
                  //         color: Colors.white,
                  //       ), //Setting the border color
                  //     ),
                  //     errorBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  //       borderSide: BorderSide(
                  //         width: 2,
                  //         color: Colors.red,
                  //       ), //Setting the border color
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(height: 20.0),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: storeUserData,
                      child: const Text(
                        'Next',
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
