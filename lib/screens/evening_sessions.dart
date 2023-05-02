import 'package:flutter/material.dart';
import 'package:gripngrab/cancel_page.dart';
import 'package:gripngrab/models/app_model.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/providers/sessions_provider.dart';
import 'package:gripngrab/screens/thanks_page.dart';
import 'package:gripngrab/screens/widgets/session_loading_screens.dart';
import 'package:gripngrab/utils/colors.dart';
import 'package:gripngrab/utils/utils.dart';
import 'package:provider/provider.dart';

class EveningSession extends StatefulWidget {
  const EveningSession({super.key});

  @override
  State<EveningSession> createState() => _EveningSessionState();
}

class _EveningSessionState extends State<EveningSession> {
  late SessionsProvider sessionsProvider;
  late AuthProvider authProvider;

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
    sessionsProvider = Provider.of<SessionsProvider>(context, listen: true);
    authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
        backgroundColor: kPrimaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(
            color: kLeadingAppBarIconColor,
          ),
        ),
        body: StreamBuilder(
          stream:
              sessionsProvider.getSessions(sessionType: SessionType.evening),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // sorting based on ascending order
              snapshot.data!.sort(
                (a, b) => int.parse(a.timeFrame.split('-')[0]).compareTo(
                  int.parse(b.timeFrame.split('-')[0]),
                ),
              );
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/entry.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.30,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: kPrimaryColor,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Text(
                                'Time',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(
                                'Slots Available',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          // building our time slots
                          ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              bool isCurrentSession = false;
                              if (sessionsProvider.currentSessionId != null &&
                                  sessionsProvider
                                      .currentSessionId!.isNotEmpty &&
                                  snapshot.data![index].id ==
                                      sessionsProvider.currentSessionId) {
                                isCurrentSession = true;
                              }
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (authProvider.eveningBooked) {
                                    // current booked slot can be canceled here
                                    if (isCurrentSession) {
                                      openDialog(
                                        context: context,
                                        sessionsModel: snapshot.data![index],
                                        isCancel: true,
                                      );
                                    } else {
                                      // showing snackbar when user clicks on other slot timings.
                                      showSnackBar(
                                        context: context,
                                        content:
                                            'Please cancel the booked slot first',
                                      );
                                    }
                                  } else {
                                    if (snapshot.data![index].available == 0) {
                                      showSnackBar(
                                        context: context,
                                        content: 'No available slots',
                                      );
                                    } else {
                                      // here we are booking the session
                                      openDialog(
                                        context: context,
                                        sessionsModel: snapshot.data![index],
                                        isCancel: false,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isCurrentSession ||
                                            snapshot.data![index].available == 0
                                        ? Colors.white
                                        : const Color(0xFF2C2C2E),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data![index].timeFrame.split('-')[0]} P.M - ${snapshot.data![index].timeFrame.split('-')[1]} P.M',
                                            style: TextStyle(
                                              color: isCurrentSession ||
                                                      snapshot.data![index]
                                                              .available ==
                                                          0
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            getDate(
                                                startValue: int.parse(snapshot
                                                    .data![index].timeFrame
                                                    .split('-')[0]),
                                                isShort: true,
                                                isMorning: false),
                                            style: TextStyle(
                                              color: isCurrentSession ||
                                                      snapshot.data![index]
                                                              .available ==
                                                          0
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${snapshot.data![index].available}',
                                        style: TextStyle(
                                          color: isCurrentSession ||
                                                  snapshot.data![index]
                                                          .available ==
                                                      0
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SessionsLoadingScreen();
          },
        ));
  }

  // book session
  void openDialog({
    required BuildContext context,
    required SessionsModel sessionsModel,
    bool isCancel = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                sessionsModel.sessionType == SessionType.morning
                    ? '${sessionsModel.timeFrame.split('-')[0]} A.M - ${sessionsModel.timeFrame.split('-')[1]} ${sessionsModel.timeFrame.split('-')[1] == '12' ? 'P.M' : 'A.M'}'
                    : '${sessionsModel.timeFrame.split('-')[0]} P.M - ${sessionsModel.timeFrame.split('-')[1]} P.M',
                style: const TextStyle(color: Colors.white),
              ),
              content: Text(
                getDate(
                  startValue: int.parse(sessionsModel.timeFrame.split('-')[0]),
                  isShort: false,
                  isMorning: false,
                ),
                style: const TextStyle(color: Colors.white70),
              ),
              backgroundColor: kTabBackgroundColor,
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (isCancel) {
                      setState(() {
                        sessionsProvider.setLoading(isLoading: true);
                      });
                      sessionsProvider.cancelSession(
                          context: context,
                          sessionsModel: sessionsModel,
                          onSuccess: () async {
                            await authProvider
                                .updateUserBookingStatus(
                              sessionType: sessionsModel.sessionType,
                              isCanceled: true,
                            )
                                .whenComplete(() {
                              setState(() {
                                sessionsProvider.setLoading(isLoading: false);
                              });
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const CancelPage(),
                                ),
                              );
                            });
                          },
                          authProvider: authProvider);
                    } else {
                      setState(() {
                        sessionsProvider.setLoading(isLoading: true);
                      });

                      sessionsProvider.bookSession(
                          authProvider: authProvider,
                          context: context,
                          sessionsModel: sessionsModel,
                          onSuccess: () async {
                            await authProvider
                                .updateUserBookingStatus(
                              sessionType: sessionsModel.sessionType,
                            )
                                .whenComplete(() {
                              setState(() {
                                sessionsProvider.setLoading(isLoading: false);
                              });
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const ThanksScreen(),
                                ),
                              );
                            });
                          });
                    }
                  },
                  child: sessionsProvider.isLoading == true
                      ? Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 20,
                          child: const CircularProgressIndicator(
                              color: kPrimaryColor),
                        )
                      : Text('${!isCancel ? 'Book' : 'Cancel'} a session'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    disabledForegroundColor: Colors.white,
                  ),
                  onPressed: !sessionsProvider.isLoading
                      ? () => Navigator.of(context).pop()
                      : null,
                  child: const Text('Cancel'),
                )
              ],
            );
          });
        });
  }
}
