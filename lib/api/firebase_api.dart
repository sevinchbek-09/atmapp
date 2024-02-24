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
  void handleMessage (RemoteMessage? message){
    if(message==null) return;
  }
  Future initPushNotifications()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true

    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(hundleBackgrounMessage);
  }
  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fCMToken= await _firebaseMessaging.getToken();
    print(fCMToken);
    initPushNotifications();
    FirebaseMessaging.onBackgroundMessage(hundleBackgrounMessage);
  }
}