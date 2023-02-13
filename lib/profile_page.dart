import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'landing_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "John Doe";
  String _mobileNumber = "1234567890";
  String _membershipStatus = "Premium";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF1C1C1E),
      appBar: null,
        body: Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
       
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://i.pravatar.cc/150?img=7"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                // Navigate to edit profile page
              },
              child: Text(
                _name,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Mobile Number: $_mobileNumber",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Membership Status: $_membershipStatus",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        ),
      ),
            bottomNavigationBar: GNav(
        gap: 3,
        activeColor: Color(0xFFBACBD3),
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 17),
        duration: Duration(milliseconds: 700),
        onTabChange: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LandingPage() ,
              ),
            );
          }
        },
        tabBackgroundColor: Color(0xFF2C2C2E),
        tabs: const [
            GButton(
            iconColor: Color(0xFFBACBD3),
            icon: Icons.person,
            text: 'Profile',
          ),
          GButton(
            iconColor: Color(0xFFBACBD3),
            icon: Icons.home,
            text: 'Home',
          ),

        ],
        selectedIndex: 0,
      ),
      );
  }
}
