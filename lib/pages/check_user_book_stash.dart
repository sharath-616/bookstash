import 'package:bookstash/services/auth_class_helper.dart';
import 'package:bookstash/utilities/message.dart';
import 'package:flutter/material.dart';

class CheckUserBookStash extends StatefulWidget {
  const CheckUserBookStash({super.key});

  @override
  State<CheckUserBookStash> createState() => _CheckUserBookStashState();
}

class _CheckUserBookStashState extends State<CheckUserBookStash> {

//  to identify  the user logged or  not
// if the user login allready to home page otherwise login page 

@override
  void initState() {
 AuthClassHelper.isUserLoggedin().then((value){
 if(value == true){
   Navigator.pushReplacementNamed(context, "/home");
 }else{
  Navigator.pushReplacementNamed(context, "/login");
  Message.show(msg: "Please login");
 }
 });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: Colors.black,value: 5,),
      ), 
    );
  }
}


