import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/gender.dart';
import 'package:gripngrab/thanks_page.dart';
import 'package:provider/provider.dart';

import 'auth_provider_page.dart';

class MorningSessionPage extends StatefulWidget {
  @override
  _MorningSessionPage createState() => _MorningSessionPage();
}

class _MorningSessionPage extends State<MorningSessionPage> {
  Future openDialog(String sessionTime) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              sessionTime,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF2C2C2E),
            actionsAlignment: MainAxisAlignment.center,
            // content: Text("This slot is already booked"),
            actions: [
              ElevatedButton(
                child: Text("Book a session"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThanksScreen(),
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
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference users =
        FirebaseFirestore.instance.collection('morningSession');
    final ap = Provider.of<AuthProvider>(context, listen: false);
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
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder<DocumentSnapshot>(
            future: users.doc("lDKjgkrC3v8rrkd6MmQQ").get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
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
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.grey[900],
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "7:00 - 8:00 A.M.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    Text(
                                      data["7:00 A.M. - 8:00 A.M."].toString() +
                                          "/5",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      data["8:00 A.M. - 9:00 A.M."].toString() +
                                          "/5",
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
                              onTap: () async {
                                // await _firebaseFirestore
                                //     .collection("morningSession")
                                //     .doc("lDKjgkrC3v8rrkd6MmQQ")
                                //     .update({"9:00 A.M. - 10:00 A.M.":
                                //       data["9:00 A.M. - 10:00 A.M."]+1
                                // });
                                openDialog("9:00 A.M. - 10:00 A.M.");
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                height: 70,
                                width: 400,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      data["9:00 A.M. - 10:00 A.M."]
                                              .toString() +
                                          "/5",
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
                              onTap: () async {
                                await _firebaseFirestore
                                    .collection("users")
                                    .doc(ap.docId)
                                    .update({});
                                openDialog("10:00 A.M. - 11:00 A.M.");
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                height: 70,
                                width: 400,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      data["10:00 A.M. - 11:00 A.M."]
                                              .toString() +
                                          "/5",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      data["11:00 A.M. - 12:00 A.M."]
                                              .toString() +
                                          "/5",
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
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
