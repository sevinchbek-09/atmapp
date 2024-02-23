import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> hundleBackgrounMessage(RemoteMessage message)async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('PayLoad: ${message.notification?.title}');
  // print('bodykey: ${message.notification?.bodyLocKey}');
  // print('Android: ${message.notification?.android}');

}
class FirebaseApi{
  final _firebaseMessaging=FirebaseMessaging.instance;
  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fCMToken= await _firebaseMessaging.getToken();
    print(fCMToken);
    FirebaseMessaging.onBackgroundMessage(hundleBackgrounMessage);
  }
}