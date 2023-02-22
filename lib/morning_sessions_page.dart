import 'package:flutter/material.dart';
import 'package:gripngrab/gender.dart';
class MorningSessionPage extends StatefulWidget {
  @override
  _MorningSessionPageState createState() => _MorningSessionPageState();
}

class _MorningSessionPageState extends State<MorningSessionPage> {
  Future openDialog(String sessionTime) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(sessionTime),
            // content: Text("This slot is already booked"),
            actions: [
              ElevatedButton(
                child: Text("Book a session"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
                 ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
             decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(30),
              //   bottomRight: Radius.circular(30),
              // ),
              image: DecorationImage(
                image: AssetImage('assets/images/session.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.grey[900],
            ),
            padding: EdgeInsets.all(16.0),
          child: Column(
          children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text(
                "Slots",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          InkWell(
          onTap: () {
            openDialog("7:00 A.M. - 8:00 A.M.");
            },
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: 70,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text("7:00 - 8:00 A.M.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
                  "3/5",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
              openDialog("8:00 A.M. - 9:00 A.M.");
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              height: 70,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "8:00 - 9:00 A.M.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Text(
                    "3/5",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
              openDialog("9:00 A.M. - 10:00 A.M.");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GenderPage(),
              //   ),
              // );
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              height: 70,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "9:00 - 10:00 A.M.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Text(
                    "3/5",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
              openDialog("10:00 A.M. - 11:00 A.M.");
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              height: 70,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "10:00 - 11:00 A.M.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "3/5",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
              openDialog("11:00 A.M. - 12:00 P.M.");
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              height: 70,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "11:00 - 12:00 A.M.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "3/5",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 12),
          
          ],
          ),
          ),
        ],
      ),
      );
      // ignore: dead_code
      
  }
}