import 'package:bookstash/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationHelperService {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      sound: true,
      provisional: true,
    );

    //get the device tocken

    final token = await _firebaseMessaging.getToken();
    print("device token $token");
  }

  static Future localNotificationInitialization() async {
    // android

    const AndroidInitializationSettings initializationSettingsForAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    // ios

    // final DarwinInitializationSettings initializationSettingsForiOS = DarwinInitializationSettings(
    //   onDideReciveLocalNotification :(id, title, body , payload) => null,
    // );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsForAndroid,
      // iOS: initializationSettingsForiOS,
    );

    //permision for android 13 above

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .requestExactAlarmsPermission();
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }
  //onTap local notification

  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!.pushNamed("/message", arguments: notificationResponse);
  }

  static Future showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }
}
