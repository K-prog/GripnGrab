import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gripngrab/evening_sessions_page.dart';
import 'package:gripngrab/gender.dart';
import 'package:gripngrab/profile_page.dart';
import 'package:gripngrab/morning_sessions_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.0),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text("Hello",        //User name to be added here
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Morning Session",
                        style: TextStyle(
                           fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      //add date widget here
                    ],
                  ),
                  SizedBox(height: 12.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MorningSessionPage(),
                        ),
                      );
                    },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF2C2C2E),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          child: Image.asset(
                            "assets/images/morning.png",
                            height: 95,
                            width: 95,
                          ),
                        ),
                          Text(
                            "7:00 - 12:00 P.M.",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                               fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), 
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Evening Session",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                           fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  InkWell(
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EveningSessionPage(),
                        ),
                      );
                    },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10.0),
                         color: Color(0xFF2C2C2E),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Container(
                          height: 95,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF2C2C2E),
                          ),
                          child: Image.asset(
                            "assets/images/evening.png", 
                             height: 95,
                              width: 95,                          
                          ),
                        ),
                          Text(
                            "4:00 - 10:00 P.M.",
                            style: TextStyle(
                              fontSize: 16.0,
                               fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
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
                builder: (context) => LandingPage(),
              ),
            );
          } else if (index == 1) {
               Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          }
        },
        tabBackgroundColor: Color(0xFF2C2C2E),
        tabs: const[
          GButton(
            iconColor: Color(0xFFBACBD3),
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            iconColor: Color(0xFFBACBD3),
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
        selectedIndex: 0,
        
      ),
      );
  }
}
