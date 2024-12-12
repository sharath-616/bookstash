import 'dart:convert';

import 'package:bookstash/auth/Ui/login_screen.dart';
import 'package:bookstash/auth/Ui/sign_up_user.dart';
import 'package:bookstash/firebase_options.dart';
import 'package:bookstash/pages/check_user_book_stash.dart';
import 'package:bookstash/pages/home_page.dart';
import 'package:bookstash/services/message_screen.dart';
import 'package:bookstash/services/push_notification_helper_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

//out side the context navigation   .......
//to show  notification message in another apage

final navigatorKey = GlobalKey<NavigatorState>();

Future _fireBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("A Notifiation found in background..!");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //initialisation Firebase messages
  await PushNotificationHelperService.init();

//initialisation local notification

  await PushNotificationHelperService.localNotificationInitialization();
  FirebaseMessaging.onBackgroundMessage(_fireBackgroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped ...!");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  //forground

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadCOntent = jsonEncode(message.data);
    print("Message fount in background..!");
    if (message.notification != null) {
      // not null
      PushNotificationHelperService.showLocalNotification(
          title: message.notification!.title!, body: message.notification!.body!, payload: payloadCOntent);
    }
  });

  //  for handling terminated state

  final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Form Terminate STate");

    Future.delayed(const Duration(seconds: 3), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Book Stash",
      // home: LoginScreen(),

      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => const CheckUserBookStash(),
        "/login": (context) => const LoginScreen(),
        '/register': (context) => const Register(),
        "/home": (context) => const HomePage(),
        "/message": (context) => const MessageScreen(),
      },
    );
  }
}
