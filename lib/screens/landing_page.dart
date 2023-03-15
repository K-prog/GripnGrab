import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gripngrab/cancel_page.dart';
import 'package:gripngrab/providers/sessions_provider.dart';
import 'package:gripngrab/screens/evening_sessions.dart';
import 'package:gripngrab/screens/morning_sessions.dart';
import 'package:gripngrab/user_details.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:gripngrab/utils/utils.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late AuthProvider authProvider;
  late SessionsProvider sessionsProvider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      authProvider = Provider.of<AuthProvider>(context, listen: false);
      sessionsProvider = Provider.of<SessionsProvider>(context, listen: false);
      authProvider.getUserBookingStatus(sessionsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: true);

    var gg = GetUserName;
    var gg1 = gg;
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to exit an App'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No',
                        style: TextStyle(color: Color(0xFFBACBD3))),
                  ),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text('Yes',
                        style: TextStyle(color: Color(0xFFBACBD3))),
                  ),
                ],
              ),
            )) ??
            false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Morning Session",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        buildMorningSession(),
                        const SizedBox(height: 20.0),
                        const Text(
                          "Evening Session",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        buildEveningSession(),
                        const SizedBox(height: 16.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     ElevatedButton(
                        //       child: const Text(
                        //         "Cancel Session",
                        //         style: TextStyle(
                        //             color: Color(0xFF1C1C1E),
                        //             fontFamily: "Montserrat",
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 15),
                        //       ),
                        //       onPressed: () {
                        //         cancelSession();
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 60.0)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: MediaQuery.of(context).size.height * 0.05,
                  child: Text(
                    "Hello ${authProvider.userModel!.firstName} 👋", //User name to be added here
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              ],
            ),
          ),
          // bottomNavigationBar: GNav(
          //   gap: 3,
          //   activeColor: Color(0xFFBACBD3),
          //   iconSize: 24,
          //   padding: EdgeInsets.symmetric(horizontal: 70, vertical: 17),
          //   duration: Duration(milliseconds: 700),
          //   onTabChange: (index) {
          //     if (index == 1) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => GetUserName(ap.docId as String),
          //         ),
          //       );
          //     }
          //   },
          //   tabBackgroundColor: Color(0xFF2C2C2E),
          //   tabs: const [
          //     GButton(
          //       iconColor: Color(0xFFBACBD3),
          //       icon: Icons.home,
          //       text: 'Home',
          //     ),
          //     GButton(
          //       iconColor: Color(0xFFBACBD3),
          //       icon: Icons.person,
          //       text: 'Profile',
          //     ),
          //   ],
          //   selectedIndex: 0,
          // ),
        ),
      ),
    );
  }

  // open dialog
  Future cancelSession() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Are you sure you want to cancel the session?",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF2C2C2E),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                child: const Text("Confirm"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CancelPage(),
                    ),
                  );
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  buildMorningSession() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColorFiltered(
        colorFilter: authProvider.eveningBooked == true
            ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
            : const ColorFilter.mode(Colors.transparent, BlendMode.color),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (authProvider.eveningBooked == false) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MorningSession()),
              );
            } else {
              showSnackBar(
                context: context,
                content:
                    'Please cancel evening session first to book morning session',
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/morning.png',
                  height: 95,
                  width: 95,
                ),
                authProvider.morningBooked
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MorningSession()),
                          );
                        },
                        child: const Text('Cancel Session'))
                    : Text(
                        '7:00 A.M - 12:00 P.M',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          fontWeight: authProvider.morningBooked
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildEveningSession() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColorFiltered(
        colorFilter: authProvider.morningBooked == true
            ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
            : const ColorFilter.mode(Colors.transparent, BlendMode.color),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (authProvider.morningBooked == false) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EveningSession()),
              );
            } else {
              showSnackBar(
                context: context,
                content:
                    'Please cancel morning session first to book evening session',
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/evening.png',
                  height: 95,
                  width: 95,
                ),
                authProvider.eveningBooked
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EveningSession()),
                          );
                        },
                        child: const Text('Cancel Session'))
                    : Text(
                        '4:00 P.M - 10:00 P.M',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: authProvider.eveningBooked
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
