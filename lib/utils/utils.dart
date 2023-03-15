import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

// show snackbar
void showSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// formatting date

String getDate(
    {required int startValue, required bool isShort, required bool isMorning}) {
  DateTime now = DateTime.now();
  DateTime startTime = DateTime(now.year, now.month, now.day, startValue, 0);

  // Check if the current time is before the start time of the session
  if (isMorning) {
    if (now.isBefore(startTime)) {
      // Show today's date
      String formattedDate = isShort
          ? DateFormat('dd MMM').format(now)
          : DateFormat('dd MMM yyyy').format(now);
      return formattedDate;
    } else {
      // Show tomorrow's date
      DateTime tomorrow = now.add(const Duration(days: 1));
      String formattedDate = isShort
          ? DateFormat('dd MMM').format(tomorrow)
          : DateFormat('dd MMM yyyy').format(tomorrow);
      return formattedDate;
    }
  } else {
    if (now.hour < startValue + 12) {
      // Show today's date
      String formattedDate = isShort
          ? DateFormat('dd MMM').format(now)
          : DateFormat('dd MMM yyyy').format(now);
      return formattedDate;
    } else {
      // Show tomorrow's date
      DateTime tomorrow = now.add(const Duration(days: 1));
      String formattedDate = isShort
          ? DateFormat('dd MMM').format(tomorrow)
          : DateFormat('dd MMM yyyy').format(tomorrow);
      return formattedDate;
    }
  }
}

// pick image
Future<File?> pickImageFromGallery(
    BuildContext context, ImageSource imageSource) async {
  File? image;
  try {
    await ImagePicker()
        .pickImage(source: imageSource, imageQuality: 20)
        .then((value) async {
      if (value != null) {
        image = File(value.path);
      }
    });
  } on PlatformException catch (e) {
    if (e.code == 'camera_access_denied') {
      customDialogPermission(context: context, isCamera: true);
    } else if (e.code == 'photo_access_denied') {
      customDialogPermission(context: context, isCamera: false);
    } else {}
  }
  return image;
}

// showing dialog for not enabling microphone permissions
void customDialogPermission(
    {required BuildContext context, bool isCamera = false}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
                'Activated ${isCamera ? 'camera' : 'photo gallery'} permissions are required for the user chat. Please activate this in the settings.'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Open Settings'),
                onPressed: () async {
                  await openAppSettings();
                },
              ),
            ],
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
                'Activated ${isCamera ? 'camera' : 'microphone'} permissions are required for the user chat. Please activate this in the settings.'),
            actions: [
              TextButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  )),
              TextButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  onPressed: () async {
                    await openAppSettings();
                  },
                  child: const Text(
                    "Open Settings",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  )),
            ],
          );
        });
  }
}
