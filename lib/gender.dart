import 'package:flutter/material.dart';
import 'package:gripngrab/birth_page.dart';
import 'package:gripngrab/landing_page.dart';

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
  static String gender = "";
}

class _GenderPageState extends State<GenderPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Color(0xFFBACBD3), // <-- SEE HERE
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50, // <-- SEE HERE
            ),
            Text(
              'Tell us about yourself!',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 30),
            ),
            SizedBox(
              height: 10, // <-- SEE HERE
            ),
            Text(
              'To give you a better experience we need',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              'to know your gender',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            SizedBox(
              height: 50, // <-- SEE HERE
            ),
            ElevatedButton(
              onPressed: () {
                GenderPage.gender = "male";
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BirthdatePage(),
                  ),
                );

              },
              child: Column(
                children:[ Icon(
                //<-- SEE HERE
                Icons.male,
                color: Color.fromRGBO(234, 239, 243, 1),
                size: 94,
              ),
              Text("Male",style: TextStyle(color: Color.fromRGBO(234, 239, 243, 1),
                          fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
                style: ElevatedButton.styleFrom(
                shape: CircleBorder(), //<-- SEE HERE
                padding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(
              height: 50, // <-- SEE HERE
            ),
            ElevatedButton(
              onPressed: () {
                GenderPage.gender="female";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BirthdatePage(),
                  ),
                );
              },
              child:Column
              (children:[ 
                Icon(
                //<-- SEE HERE
                Icons.female,
                color: Color.fromRGBO(234, 239, 243, 1),
                size: 94,
              ),
              Text("Female", style: TextStyle(color: Color.fromRGBO(234, 239, 243, 1),
                          fontWeight: FontWeight.bold, fontSize: 15)),
              ],
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), //<-- SEE HERE
                padding: EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
