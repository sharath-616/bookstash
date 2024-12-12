import 'package:bookstash/services/auth_class_helper.dart';
import 'package:bookstash/utilities/custom_text_widgets.dart';
import 'package:bookstash/utilities/message.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                text: 'Sign Up',
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
                      await AuthClassHelper.createAccountWithEmail(emailTextController.text, passwordController.text)
                          .then((value) {
                        if (value == "Account Created ..!") {
                          Message.show(msg: "Account Created Successfuly");
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        } else {
                          Message.show(msg: "Error $value");
                        }
                      });
                    },
                    child: const CustomTextWidgets(
                      text: "Sign Up",
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomTextWidgets(text: "Already have an account..?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomTextWidgets(
                        text: "Login",
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
