// import 'dart:async';
// import 'dart:js';

// import 'package:flutter/material.dart';

// import 'main.dart';

// class HomePage extends StatelessWidget {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 2), () {
//       Navigator.pushReplacementNamed(
//           context as BuildContext, const LoginPage() as String);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FittedBox(
//               child: Image.asset('assets/vids/final_intro.gif'),
//               fit: BoxFit.fill,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
