import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String gender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: null,
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
              onPressed: () {},
              child: Icon(
                //<-- SEE HERE
                Icons.male,
                color: Color.fromRGBO(234, 239, 243, 1),
                size: 94,
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
              onPressed: () {},
              child: Icon(
                //<-- SEE HERE
                Icons.female,
                color: Color.fromRGBO(234, 239, 243, 1),
                size: 94,
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
