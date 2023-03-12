import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/screens/mybottom_bar.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BirthdatePage extends StatefulWidget {
  const BirthdatePage({super.key});

  @override
  State<BirthdatePage> createState() => _BirthdatePageState();
}

class _BirthdatePageState extends State<BirthdatePage> {
  //int selectedYear = 2000, selectedMonth = 1, selectedDate = 1;
  late AuthProvider authProvider;
  DateTime selectedDate = DateTime.now();

  void createUserProfile() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.setLoading(isLoading: true);
    authProvider.userModel!.dateOfBirth =
        DateFormat('dd-MM-yyyy').format(selectedDate);

    await authProvider
        .saveUserDataToFirebase(
          context: context,
          userModel: authProvider.userModel!,
          profilePic: authProvider.selectedUserImage!,
        )
        .then((value) => authProvider
                .saveDataToSP()
                .then((value) => authProvider.setSignIn())
                .whenComplete(() {
              authProvider.setLoading(isLoading: false);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyBottomBar(selectedIndex: 0)));
            }));
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'How old are you?',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'This help us create your personalized plan',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize:
                          MediaQuery.of(context).size.width < 300 ? 16 : 20,
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 350,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    minimumYear: 1900,
                    dateOrder: DatePickerDateOrder.dmy,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        selectedDate = newDateTime;
                      });
                      // Do something when the date is changed
                    },
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // back button
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kTabBackgroundColor,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: createUserProfile,
                      child: authProvider.isLoading == true
                          ? Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                  color: kPrimaryColor),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Color(0xFF1C1C1E),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                    ),
                  ),
                ],
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.3,
              //       child: DropdownButton<int>(
              //         hint: Text("Date"),
              //         dropdownColor: Color.fromRGBO(30, 60, 87, 1),
              //         value: selectedDate,
              //         items: List.generate(
              //           31,
              //           (index) => DropdownMenuItem(
              //             child: Text(
              //               "${index + 1}",
              //               style: TextStyle(color: Colors.white),
              //             ),
              //             value: index + 1,
              //           ),
              //         ),
              //         onChanged: (value) {
              //           setState(() {
              //             selectedDate = value!;
              //           });
              //         },
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width * 0.3,
              //       child: DropdownButton<int>(
              //         hint: Text("Month"),
              //         dropdownColor: Color.fromRGBO(30, 60, 87, 1),
              //         value: selectedMonth,
              //         items: List.generate(
              //           12,
              //           (index) => DropdownMenuItem(
              //             child: Text(
              //               "${index + 1}",
              //               style: TextStyle(color: Colors.white),
              //             ),
              //             value: index + 1,
              //           ),
              //         ),
              //         onChanged: (value) {
              //           setState(() {
              //             selectedMonth = value!;
              //           });
              //         },
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width * 0.3,
              //       child: DropdownButton<int>(
              //         hint: Text("Year"),
              //         dropdownColor: Color.fromRGBO(30, 60, 87, 1),
              //         value: selectedYear,
              //         items: List.generate(
              //           100,
              //           (index) => DropdownMenuItem(
              //             child: Text(
              //               "${index + 1920}",
              //               style: TextStyle(color: Colors.white),
              //             ),
              //             value: index + 1920,
              //           ),
              //         ),
              //         onChanged: (value) {
              //           setState(() {
              //             selectedYear = value!;
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ),

              //  Image.asset(
              //   'assets/images/dob.png',
              //   width: double.infinity,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
