import 'dart:convert';

import 'package:bookstash/utilities/custom_text_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Map payloadCOntent = {};
  @override
  Widget build(BuildContext context) {

    // useing to ModelRout..?  to know the informations of current Route
    final data = ModalRoute.of(context)!.settings.arguments;

//background terminated state
    if (data is RemoteMessage) {
      payloadCOntent = data.data;
    }

    //forground state

    if (data is NotificationResponse) {
      //decode to json
      payloadCOntent = jsonDecode(data.payload!);
    }

    //Model Route using for the information of current route

    String firstKey = payloadCOntent.keys.first;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.amber,
        title: const CustomTextWidgets(
          text: "Messages",
          clr: Colors.black,
          fw: FontWeight.bold,
          fz: 20,
          lp: 1,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: const Color.fromARGB(255, 61, 1, 43),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextWidgets(
                      text: "Book Name : $firstKey",
                      clr: Colors.white,
                      fw: FontWeight.bold,
                      fz: 30,
                      lp: 1,
                    ),
                  ),
                ),
              ),

                 SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: const Color.fromARGB(255, 61, 1, 43),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextWidgets(
                      text: "Price : ${payloadCOntent[firstKey]}",
                      clr: Colors.white,
                      fw: FontWeight.bold,
                      fz: 30,
                      lp: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
