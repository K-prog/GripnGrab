import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gripngrab/providers/mybottom_bar_provider.dart';
import 'package:gripngrab/screens/landing_page.dart';
import 'package:gripngrab/screens/settings_page.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:provider/provider.dart';

class MyBottomBar extends StatefulWidget {
  final int selectedIndex;
  const MyBottomBar({super.key, required this.selectedIndex});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  late MyBottomNavBarViewModel myBottomNavBarViewModel;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      myBottomNavBarViewModel =
          Provider.of<MyBottomNavBarViewModel>(context, listen: false);
      myBottomNavBarViewModel.selectedTab(widget.selectedIndex, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myBottomNavBarViewModel =
        Provider.of<MyBottomNavBarViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: IndexedStack(
        index: myBottomNavBarViewModel.currentIndex,
        children: const [
          LandingPage(),
          SettingsPage(),
        ],
      ),
      // bottom navigation bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: GNav(
          gap: 20,
          activeColor: kTabActiveColor,
          iconSize: 24,
          duration: const Duration(milliseconds: 600),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          onTabChange: (index) {
            myBottomNavBarViewModel.setCurrentIndex(index);
          },
          tabBackgroundColor: kTabBackgroundColor,
          tabs: const [
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
          selectedIndex: myBottomNavBarViewModel.currentIndex,
        ),
      ),
    );
  }
}
