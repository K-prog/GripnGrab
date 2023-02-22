import 'package:flutter/material.dart';
import 'package:gripngrab/gender.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
  static String firstName = "";
  static String lastName= "";
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: null,
      body: SingleChildScrollView(child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
        children: [
          SizedBox(height: 40.0),
          CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
              radius: 80,
            ),
            SizedBox(height: 20.0),
          TextField(
            controller: _firstNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'First Name',
              hintText: 'Enter your first name',
              hintStyle: MaterialStateTextStyle.resolveWith(
                    (states) => TextStyle(color: Colors.white)),
              labelStyle: MaterialStateTextStyle.resolveWith((states) => TextStyle(color: Color(0xFFBACBD3), fontFamily: 'Montserrat')),
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _lastNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelStyle: MaterialStateTextStyle.resolveWith((states) => TextStyle(color: Color(0xFFBACBD3), fontFamily: 'Montserrat')),
              labelText: 'Last Name',
              hintText: 'Enter your last name',
              hintStyle: MaterialStateTextStyle.resolveWith(
                    (states) => TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenderPage(),
                ),
              );
              // do something with the input data
              InputScreen.firstName=_firstNameController.text.trim();
              InputScreen.lastName=_lastNameController.text.trim();
            },
            child: Text('Submit' , style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
      ),
    ),
    );
  }
}
