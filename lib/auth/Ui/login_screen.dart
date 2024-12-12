import 'package:bookstash/services/auth_class_helper.dart';
import 'package:bookstash/utilities/custom_text_widgets.dart';
import 'package:bookstash/utilities/message.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CustomTextWidgets(
                text: 'Login',
                clr: Colors.black,
                fw: FontWeight.bold,
                fz: 30,
                lp: 1,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: emailTextController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      label: CustomTextWidgets(
                        text: "Email",
                        clr: Colors.black,
                        fz: 20,
                        fw: FontWeight.normal,
                        lp: 1,
                      ),
                      hintText: "Enter Your Mail",
                      helperStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      label: CustomTextWidgets(
                        text: "Password",
                        clr: Colors.black,
                        fz: 20,
                        fw: FontWeight.normal,
                        lp: 1,
                      ),
                      hintText: "Enter Your Password",
                      helperStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await AuthClassHelper.loginWithEmail(emailTextController.text, passwordController.text)
                          .then((value) {
                        if (value == "Login Seccess..!") {
                          Message.show(msg: "Login Successfull..!");
                         Navigator.pushReplacementNamed(context, "/home");
                        } else {
                          Message.show(msg: "Sign up first");
                        }
                      });
                    },
                    child: const CustomTextWidgets(
                      text: "Login",
                      clr: Colors.white,
                      fw: FontWeight.bold,
                      fz: 20,
                      lp: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTextWidgets(text: "Need an account ..?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const CustomTextWidgets(
                        text: "Register",
                        clr: Colors.black,
                        fz: 20,
                        fw: FontWeight.w600,
                        lp: 1,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
