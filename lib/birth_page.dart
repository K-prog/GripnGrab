import 'package:flutter/material.dart';
import 'package:gripngrab/landing_page.dart';
import 'package:gripngrab/main.dart';

class BirthdatePage extends StatefulWidget {
  @override
  _BirthdatePageState createState() => _BirthdatePageState();
}

class _BirthdatePageState extends State<BirthdatePage> {
  int selectedYear = 2000, selectedMonth = 1, selectedDate = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Text(
              "How old are you?",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 30),
            ),
            SizedBox(
              height: 50, // <-- SEE HERE
            ),
            Text(
              "This helps us to create your personalised plan",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 15),
            ),
            SizedBox(height: 20),
            Row(
                  children:[
                    Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DropdownButton<int>(
                      hint: Text("Date"),
                      dropdownColor: Color.fromRGBO(30, 60, 87, 1),
                      value: selectedDate,
                      items: List.generate(
                        31,
                        (index) => DropdownMenuItem(
                          child: Text("${index + 1}", style: TextStyle(color: Colors.white),),
                          value: index + 1,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDate = value!;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DropdownButton<int>(
                      hint: Text("Month"),
                      dropdownColor: Color.fromRGBO(30, 60, 87, 1),
                      value: selectedMonth,
                      items: List.generate(
                        12,
                        (index) => DropdownMenuItem(
                          child: Text("${index + 1}",style: TextStyle(color: Colors.white),),
                          value: index + 1,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value!;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DropdownButton<int>(
                      hint: Text("Year"),
                      dropdownColor: Color.fromRGBO(30, 60, 87, 1),
                      value: selectedYear,
                      items: List.generate(
                        100,
                        (index) => DropdownMenuItem(
                          child: Text("${index + 1920}",style: TextStyle(color: Colors.white),),
                          value: index + 1920,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),
                  ),
                  ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => LandingPage(),
                  ),
                );
              }, child: null,
            ),
          ],
              ),
            ),
       );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// class BirthdatePage extends StatefulWidget {
//   @override
//   _BirthdatePageState createState() => _BirthdatePageState();
// }

// class _BirthdatePageState extends State<BirthdatePage> {
//   int selectedYear = 2000, selectedMonth = 1, selectedDate = 1;

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//         backgroundColor: Color(0xFF1C1C1E),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 60),
//             Text(
//               "How old are you?",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.w800,
//                   fontSize: 30),
//             ),
//             SizedBox(
//               height: 10, // <-- SEE HERE
//             ),
//             Text(
//               "This helps us to create your personalised plan",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.w800,
//                   fontSize: 15),
//             ),
//             // SizedBox(height: 20),
//             // SizedBox(
//             //   height: 200,
//             //   child: 
//               CupertinoTheme(
//         data: CupertinoThemeData(
//           textTheme: CupertinoTextThemeData(
//             pickerTextStyle: TextStyle(
//               color: CupertinoColors.white,
//             ),
//           ),
//         ),
//         child: CupertinoDatePicker(
//           mode: CupertinoDatePickerMode.date,
//           use24hFormat: true,
//           initialDateTime: DateTime.now(),
//           onDateTimeChanged: (DateTime newDateTime) {
//             // Do something with the selected date
//           },
//           maximumDate: DateTime(2100),
//           minimumDate: DateTime(1900),
//           minuteInterval: 1,
//           backgroundColor: CupertinoColors.white,
//         ),
//       ),
//     ],),
          
//     );
//               // CupertinoTheme(
//               //   data: CupertinoThemeData(
//               //     textTheme: CupertinoTextThemeData(
//               //       pickerTextStyle: TextStyle(
//               //         color: Colors.white,
//               //       ),
//               //     ),
//               //   ),
//               //   child: CupertinoDatePicker(
//               //     mode: CupertinoDatePickerMode.date,
//               //     initialDateTime: DateTime(1969, 1, 1),
//               //     onDateTimeChanged: (DateTime newDateTime) {},
//               //   ),
//               // ),


//               // CupertinoDatePicker(
//               //   mode: CupertinoDatePickerMode.date,
//               //   initialDateTime: DateTime(1969, 1, 1),
//               //   onDateTimeChanged: (DateTime newDateTime) {
//               //   },
//               // ),
            
        

//         //Container(
//         //   padding: EdgeInsets.all(20),
//         //   child: Column(
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     children: [
//         //       Text("Enter Your Birthdate"),
//         //       SizedBox(height: 20),
//         //       Container(
//         //         height: 50,
//         //         child: Row(
//         //           mainAxisAlignment: MainAxisAlignment.center,
//         //           children: [
//         //             Container(
//         //               width: MediaQuery.of(context).size.width * 0.3,
//         //               child: DropdownButton<int>(
//         //                 hint: Text("Date"),
//         //                 value: selectedDate,
//         //                 items: List.generate(
//         //                   31,
//         //                   (index) => DropdownMenuItem(
//         //                     child: Text("${index + 1}"),
//         //                     value: index + 1,
//         //                   ),
//         //                 ),
//         //                 onChanged: (value) {
//         //                   setState(() {
//         //                     selectedDate = value!;
//         //                   });
//         //                 },
//         //               ),
//         //             ),
//         //             Container(
//         //               width: MediaQuery.of(context).size.width * 0.3,
//         //               child: DropdownButton<int>(
//         //                 hint: Text("Month"),
//         //                 value: selectedMonth,
//         //                 items: List.generate(
//         //                   12,
//         //                   (index) => DropdownMenuItem(
//         //                     child: Text("${index + 1}"),
//         //                     value: index + 1,
//         //                   ),
//         //                 ),
//         //                 onChanged: (value) {
//         //                   setState(() {
//         //                     selectedMonth = value!;
//         //                   });
//         //                 },
//         //               ),
//         //             ),
//         //             Container(
//         //               width: MediaQuery.of(context).size.width * 0.3,
//         //               child: DropdownButton<int>(
//         //                 hint: Text("Year"),
//         //                 value: selectedYear,
//         //                 items: List.generate(
//         //                   100,
//         //                   (index) => DropdownMenuItem(
//         //                     child: Text("${index + 1920}"),
//         //                     value: index + 1920,
//         //                   ),
//         //                 ),
//         //                 onChanged: (value) {
//         //                   setState(() {
//         //                     selectedYear = value!;
//         //                   });
//         //                 },
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
        
//   }
// }
