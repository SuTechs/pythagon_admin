import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/widgets/showToast.dart';

import 'modal/collectionRef.dart';

class NotificationManager {
  /// singleton
  static final NotificationManager _singleton = NotificationManager._internal();

  factory NotificationManager() {
    return _singleton;
  }

  NotificationManager._internal();

  /// logics

  // static Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  // }

  static Future<void> init() async {
    FirebaseMessaging.instance.requestPermission();

    final token = await FirebaseMessaging.instance.getToken(
      vapidKey: _kVapidKey,
    );

    CollectionRef.admins.doc(UserData.authData!.email).update({
      'token': token!,
    }).then((value) {
      // print('Token = $token');
    });

    /// on launch
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {
    //   print('initial message = ${initialMessage.notification.toString()}');
    // }

    /// on resume
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('clicked message = ${message.notification.toString()}');
    // });

    /// foreground message
    FirebaseMessaging.onMessage.listen((message) {
      final RemoteNotification? notification = message.notification;
      if (notification != null)
        showToast("${notification.title!} ${notification.body!}");
      // ToDo: play notification sound
    });

    // /// background message
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

const _kVapidKey =
    "BH83mt0Nhw3uytKetVAwGLS_iEw-fd5auszfQneJst_ZSiPM-Kb_bYMFUWgFdtDbshvV648HdN4g27BGT3_caR8";
