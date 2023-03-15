import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gripngrab/models/app_model.dart';
import 'package:gripngrab/providers/auth_provider.dart';
import 'package:gripngrab/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionsProvider extends ChangeNotifier {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _currentSessionId;
  String? get currentSessionId => _currentSessionId;

  void setLoading({required bool isLoading}) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set sessionId(String sessionId) {
    _currentSessionId = sessionId;
    notifyListeners();
  }

  // getting list of sessions
  Stream<List<SessionsModel>> getSessions({
    required SessionType sessionType,
  }) {
    return firebaseFirestore
        .collection('sessions')
        .snapshots()
        .asyncMap((event) async {
      List<SessionsModel> sessionList = [];
      if (event.docs.isNotEmpty) {
        for (var document in event.docs) {
          var session = SessionsModel.fromJson(document.data());
          if (session.sessionType == sessionType) {
            sessionList.add(session);
          }
        }
      }
      return sessionList;
    });
  }

  Future<void> cancelSession({
    required BuildContext context,
    required SessionsModel sessionsModel,
    required Function onSuccess,
    required AuthProvider authProvider,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      QuerySnapshot snapshot = await firebaseFirestore
          .collection('sessions')
          .doc(sessionsModel.id)
          .collection('slots')
          .where('bookedBy', isEqualTo: authProvider.userModel!.id)
          .get();
      if (snapshot.docs.isNotEmpty) {
        await firebaseFirestore
            .collection('sessions')
            .doc(sessionsModel.id)
            .collection('slots')
            .doc(snapshot.docs[0].id)
            .delete();

        _currentSessionId = null;
        await sharedPreferences.setString('currentSessionId', '');

        DocumentSnapshot dSnapshot = await firebaseFirestore
            .collection('sessions')
            .doc(sessionsModel.id)
            .get();
        if (dSnapshot.exists) {
          int currentCount = dSnapshot['available'];
          if (currentCount < 5 && currentCount >= 0) {
            await firebaseFirestore
                .collection('sessions')
                .doc(sessionsModel.id)
                .update(
              {'available': currentCount + 1},
            ).whenComplete(() => onSuccess());
          }
        }
      }
    } on FirebaseException catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSessionId() async {
    final SharedPreferences ss = await SharedPreferences.getInstance();
    _currentSessionId = ss.getString('currentSessionId') ?? '';
    notifyListeners();
  }

  // book session
  Future<void> bookSession({
    required BuildContext context,
    required SessionsModel sessionsModel,
    required AuthProvider authProvider,
    required Function onSuccess,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await firebaseFirestore
          .collection('sessions')
          .doc(sessionsModel.id)
          .collection('slots')
          .add(
            SessionBooked(
              bookedAt: DateTime.now(),
              timeFrameId: sessionsModel.id,
              bookedBy: authProvider.userModel!.id,
            ).toJson(),
          );
      _currentSessionId = sessionsModel.id;
      await sharedPreferences.setString('currentSessionId', _currentSessionId!);
      // now updating the current slot count
      DocumentSnapshot snapshot = await firebaseFirestore
          .collection('sessions')
          .doc(sessionsModel.id)
          .get();
      if (snapshot.exists) {
        int currentCount = snapshot['available'];
        if (currentCount > 0 && currentCount <= 5) {
          await firebaseFirestore
              .collection('sessions')
              .doc(sessionsModel.id)
              .update(
            {'available': currentCount - 1},
          ).whenComplete(() => onSuccess());
        }
      }
    } on FirebaseException catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createSessions() async {
    final morningList = [
      '7-8',
      '8-9',
      '9-10',
      '10-11',
      '11-12',
    ];
    final eveningList = [
      '4-5',
      '5-6',
      '6-7',
      '7-8',
      '8-9',
      '9-10',
    ];
    // adding morning sessions
    for (final timeFrame in morningList) {
      DocumentReference docRef =
          await firebaseFirestore.collection('sessions').add(
                SessionsModel(
                  id: '',
                  available: 5,
                  timeFrame: timeFrame,
                  sessionType: SessionType.morning,
                ).toJson(),
              );
      await docRef.update({'id': docRef.id});
    }

    // adding evening sessions
    for (final timeFrame in eveningList) {
      DocumentReference docRef =
          await firebaseFirestore.collection('sessions').add(
                SessionsModel(
                  id: '',
                  available: 5,
                  timeFrame: timeFrame,
                  sessionType: SessionType.evening,
                ).toJson(),
              );
      await docRef.update({'id': docRef.id});
    }
  }
}
