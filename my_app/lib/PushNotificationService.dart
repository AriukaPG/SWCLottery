import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
     final fCMToken= await _firebaseMessaging.getToken();
     print('Token: $fCMToken');
    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the incoming message
      //print("Received message: ${message.notification?.body}");
    });*/
  }

  /*Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }*/
}