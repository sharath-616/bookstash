import 'package:bookstash/services/database.dart';
import 'package:bookstash/utilities/custom_text_widgets.dart';
import 'package:bookstash/utilities/message.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  TextEditingController titleControll = TextEditingController();
  TextEditingController priceControll = TextEditingController();
  TextEditingController authorControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.amber,
        title: const CustomTextWidgets(
          text: "Book",
          clr: Colors.black,
          fw: FontWeight.bold,
          fz: 20,
          lp: 1,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: CustomTextWidgets(
              text: "Title",
              clr: Colors.black,
              fw: FontWeight.w600,
              fz: 17,
              lp: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: Offset(
                      0,
                      5,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: titleControll,
                  decoration: const InputDecoration(
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: CustomTextWidgets(
              text: "Price",
              clr: Colors.black,
              fw: FontWeight.w600,
              fz: 17,
              lp: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: Offset(
                      0,
                      5,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  keyboardType:const TextInputType.numberWithOptions(),
                  controller: priceControll,
                  decoration: const InputDecoration(
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: CustomTextWidgets(
              text: "Aouthor",
              clr: Colors.black,
              fw: FontWeight.w600,
              fz: 17,
              lp: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: Offset(
                      0,
                      5,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: authorControll,
                  decoration: const InputDecoration(
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton.icon(
                onPressed: () async {
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> bookMapInfo = {
                    "Title": titleControll.text,
                    "Price : ₹": priceControll.text,
                    "Aouthor": authorControll.text,
                     'id' :id,
                  };

                  await DataBaseHelper().addBookDetails(bookMapInfo, id).then(
                    (value) {
                      Message.show(msg: "Book Added Successfully");

                      titleControll.clear();
                      priceControll.clear();
                      authorControll.clear();
                    },
                  );

                  Navigator.of(context).pop();
                },
                label: const CustomTextWidgets(
                  text: "Add",
                  clr: Colors.black,
                  fw: FontWeight.bold,
                  fz: 20,
                  lp: 1,
                ),
                icon: const Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
