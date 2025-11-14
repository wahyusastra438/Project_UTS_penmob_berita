import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
  debugPrint("Notification Title: ${message.notification?.title}");
  debugPrint("Notification Body: ${message.notification?.body}");
}


class FcmService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initFCM() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Izin notifikasi diberikan.');

      final String? token = await _fcm.getToken();
      debugPrint('=======================================');
      debugPrint('FCM Token Perangkat Anda:');
      debugPrint(token);
      debugPrint('Gunakan token ini di Firebase Console untuk tes.');
      debugPrint('=======================================');


      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Dapat notifikasi saat aplikasi TERBUKA!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint('Notification Title: ${message.notification!.title}');
          debugPrint('Notification Body: ${message.notification!.body}');
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('Pengguna mengetuk notifikasi dari BACKGROUND.');
        debugPrint('Message data: ${message.data}');
      });

      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          debugPrint('Pengguna mengetuk notifikasi dari TERMINATED.');
          debugPrint('Message data: ${message.data}');
        }
      });

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    } else {
      debugPrint('Izin notifikasi ditolak oleh pengguna.');
    }
  }
}