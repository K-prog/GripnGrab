import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/screens/auth/login_page.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          backgroundColor: Colors.white,
          color: Colors.black,
          onRefresh: () async {},
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: authProvider.userModel!.profilePhoto,
                    placeholder: (context, url) {
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, imageProvider, error) {
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40.0),
                buildItem('Name:',
                    '${authProvider.userModel!.firstName} ${authProvider.userModel!.lastName}'),
                buildItem('Number:',
                    authProvider.userModel!.phoneNumber.replaceAll('+91', '')),
                buildItem(
                  'Membership:',
                  authProvider.userModel!.membershipActivated
                      ? 'Active'
                      : 'Inactive',
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  onPressed: () {
                    authProvider.userSignOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFBACBD3),
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
