import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gripngrab/cancel_page.dart';
import 'package:gripngrab/evening_sessions_page.dart';
import 'package:gripngrab/gender.dart';
import 'package:gripngrab/profile_page.dart';
import 'package:gripngrab/morning_sessions_page.dart';
import 'package:gripngrab/user_details.dart';
import 'package:provider/provider.dart';

import 'auth_provider_page.dart';

class LandingPage extends StatelessWidget {
   // var _instance = Firestore.instance;
  @override
  Widget build(BuildContext context) {
      Future openDialog() => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Are you sure you want to cancel the session?",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFF2C2C2E),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  child: Text("Confirm"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CancelPage(),
                      ),
                    );
                  },
                ),
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
    final ap = Provider.of<AuthProvider>(context, listen: false);
    //Future<Map<String, dynamic>> gg = ap.getUserData(ap.docId as String);
    var gg= GetUserName;
    var gg1=gg;
    return WillPopScope(
    onWillPop: () async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
              child: new Text('No', style: TextStyle(color: Color(0xFFBACBD3))),
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(),// <-- SEE HERE
              child: new Text('Yes',
                        style: TextStyle(color: Color(0xFFBACBD3))),
            ),
          ],
        ),
      )) ??
      false;
} ,
    child:Scaffold(
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
                    onTap: () async {
                      //ap.getDataFromFirestore("membershipStatus");
                      if (await ap.getMembershipStatus()){
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MorningSessionPage(),
                            ),
                          );
                      }
                      else{
                         var snackBar = SnackBar(
                              content: Text(
                                  'Activate Membership to book a session',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      };
                     
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
                     onTap: () async{
                      if (await ap.getMembershipStatus()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EveningSessionPage(),
                            ),
                          );
                        } else {
                          var snackBar = SnackBar(
                              content: Text(
                                  'Activate Membership to book a session',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        ;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
           ElevatedButton(
                          child: Text(
                            "Cancel Session",
                            style: TextStyle(
                                color: Color(0xFF1C1C1E),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            openDialog();
                          },
           ),
        ],
      ),
      SizedBox( height: 60.0)
        ],
      ),
      bottomNavigationBar: GNav(
        gap: 3,
        activeColor: Color(0xFFBACBD3),
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 17),
        duration: Duration(milliseconds: 700),
        onTabChange: (index) {
          if (index == 1) {
               Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  GetUserName(ap.docId as String),
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
      ),
      );
  }
}
