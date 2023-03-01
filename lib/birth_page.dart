import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/landing_page.dart';
import 'package:gripngrab/main.dart';
import 'package:provider/provider.dart';

import 'auth_provider_page.dart';

class BirthdatePage extends StatefulWidget {
  @override
  _BirthdatePageState createState() => _BirthdatePageState();
  static String dob="";
}

class _BirthdatePageState extends State<BirthdatePage> {
  int selectedYear = 2000, selectedMonth = 1, selectedDate = 1;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Color(0xFFBACBD3), // <-- SEE HERE
        ),
      ),
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: const BackButton(
      //     color: Color(0xFFBACBD3), // <-- SEE HERE
      //   ),
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: DropdownButton<int>(
            hint: Text("Date"),
            dropdownColor: Color.fromRGBO(30, 60, 87, 1),
            value: selectedDate,
            items: List.generate(
              31,
              (index) => DropdownMenuItem(
                child: Text("${index + 1}", style: TextStyle(color: Colors.white),),
                value: index + 1,
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedDate = value!;
              });
            },
          ),
        ),
          Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DropdownButton<int>(
                      hint: Text("Month"),
                      dropdownColor: Color.fromRGBO(30, 60, 87, 1),
                      value: selectedMonth,
                      items: List.generate(
                        12,
                        (index) => DropdownMenuItem(
                          child: Text("${index + 1}",style: TextStyle(color: Colors.white),),
                          value: index + 1,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value!;
                        });
                      },
                    ),
                  ),
          Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child:
                    DropdownButton<int>(
                      hint: Text("Year"),
                      dropdownColor: Color.fromRGBO(30, 60, 87, 1),
                      value: selectedYear,
                      items: List.generate(
                        100,
                        (index) => DropdownMenuItem(
                          child: Text("${index + 1920}",style: TextStyle(color: Colors.white),),
                          value: index + 1920,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),
                ),
          ],),
              
          ElevatedButton(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Color(0xFF1C1C1E),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                onPressed: () {
                  BirthdatePage.dob = selectedDate.toString() + "/" + selectedMonth.toString() + "/" + selectedYear.toString();
                  ap.addUserDetails();
                  ap.setSignIn();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LandingPage(),
                    ),
                  );
                },
              ),
              //  Image.asset(
              //   'assets/images/dob.png',
              //   width: double.infinity,
              // ),
        ],
        )
        ),
        );
  }
}
