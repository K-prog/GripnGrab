import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gripngrab/screens/auth/login_page.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/landing_page.dart';

// class UserModel {
//  String name;
//  String gender;
//  String dob;
//  String createdAt;
// String phoneNumber;
//  String uid;
// UserModel({
// required this.name,
// required this.gender,
// required this.createdAt,
// required this.phoneNumber,
// required this.uid,
// required this.dob,
// }
// );
// factory UserModel.fromMap (Map<String, dynamic> map) {
// return UserModel(
// name: map['name'] ?? '',
// gender: map['gender'] ?? '',
// uid: map['uid'] ?? '',
// phoneNumber: map['phoneNumber'] ?? '',
// createdAt: map['createdAt'] ?? '',
// dob: map['dob'] ?? '',
// );
//   }
//   Map<String, dynamic> toMap() {
// return {
// "name": name,
// "gender": gender,
// "uid": uid,
// "dob": dob,
// "phoneNumber": phoneNumber,
// "createdAt": createdAt,
// };
// }
// }
class GetUserName extends StatelessWidget {
  final String documentId;

  String name = "";
  //String _mobileNumber = "";
  String mobileNumber = "";
  //String _membershipStatus = "";
  String membershipStatus = "";
  GetUserName(this.documentId);
  void setNames(String name, String mobileNumber, String membershipStatus) {
    this.name = name;
    this.mobileNumber = mobileNumber;
    this.membershipStatus = membershipStatus;
    //print(this.name);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LandingPage(),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF1C1C1E),
        appBar: null,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc(ap.docId).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    // _name = "${data['firstName']} ${data['lastName']}";
                    // mobileNumber = data['phone'];
                    // membershipStatus ="gg";
                    //print(ap.checkExistingUser(ap.docId));
                    setNames("${data['firstName']} ${data['lastName']}",
                        data['phone'], "gg");
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.0),
                        Text("Profile",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: Colors.white)),
                        SizedBox(height: 20.0),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                          radius: 80,
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          "Name : ",
                          style: TextStyle(
                            color: Color(0xFFBACBD3),
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          "${data['firstName']} ${data['lastName']}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          "Number : ",
                          style: TextStyle(
                            color: Color(0xFFBACBD3),
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          data['phone'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          "Membership status : ",
                          style: TextStyle(
                            color: Color(0xFFBACBD3),
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          data["membershipStatus"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 25.0),
                        ElevatedButton(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                color: Color(0xFF1C1C1E),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            ap.userSignOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                        ),
                        //
                      ],
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: CircularProgressIndicator());
              },
            )),
        bottomNavigationBar: GNav(
          gap: 3,
          activeColor: Color(0xFFBACBD3),
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 17),
          duration: Duration(milliseconds: 700),
          onTabChange: (index) {
            print(name);
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LandingPage(),
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
      ),
    );
  }
}
