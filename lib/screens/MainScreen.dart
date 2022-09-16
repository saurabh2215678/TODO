import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {

    super.initState();
    requestPermisson();
    loadFCM();
    listenFCM();
    getToken();
    FirebaseMessaging.instance.subscribeToTopic("User");
  }

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
            (token) => print(token)
    );
  }
  void requestPermisson() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    }else{
      print('User declined or has not accepted permission');
    }
  }
  void listenFCM()async{
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb){
        final largeIconPath = await Utils.downloadFile(
          'https://firebasestorage.googleapis.com/v0/b/todo-e5a01.appspot.com/o/notification_Images%2Flauncher_logo.png?alt=media&token=3f21c1ab-7266-46ae-b3c0-e8b4a20d2db0',
          'largeIcon',
        );
        final bigPicturePath = await Utils.downloadFile(
          notification.android?.imageUrl ?? 'https://firebasestorage.googleapis.com/v0/b/todo-e5a01.appspot.com/o/notification_Images%2Flauncher_logo.png?alt=media&token=3f21c1ab-7266-46ae-b3c0-e8b4a20d2db0',
          'bigPicture',
        );
        final styleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(largeIconPath),
        );

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Color(0xff4786a2),
              importance: Importance.max,
              styleInformation: notification.android?.imageUrl != null ? styleInformation : null,
              largeIcon: FilePathAndroidBitmap(largeIconPath),
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@drawable/notification_icon',
            ),
          ),
        );
      }
    });
  }
  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'wlcome todo'
        ),
      ),
    );
  }
}
