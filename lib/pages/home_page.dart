import 'package:bookstash/pages/books.dart';
import 'package:bookstash/pages/show_delete_confirmation_dialog.dart';
import 'package:bookstash/services/auth_class_helper.dart';
import 'package:bookstash/services/database.dart';
import 'package:bookstash/utilities/custom_text_widgets.dart';
import 'package:bookstash/utilities/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleControll = TextEditingController();
  TextEditingController priceControll = TextEditingController();
  TextEditingController authorControll = TextEditingController();
  Stream? bookStream;

  dynamic getInfoInit() async {
    bookStream = await DataBaseHelper().getAllbookInfo();

    setState(() {});
  }

  @override
  initState() {
    getInfoInit();
    super.initState();
  }

  Widget allBooksInfo() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      color: const Color.fromARGB(255, 61, 1, 43),
                      borderRadius: BorderRadius.circular(15),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.book_rounded,
                                    size: 30,
                                    color: Colors.amber,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("Tapped on the item");
                                      titleControll.text = documentSnapshot["Title"];
                                      priceControll.text = documentSnapshot["Price : ₹"];
                                      authorControll.text = documentSnapshot["Aouthor"];
                                      editBook(documentSnapshot["id"]);
                                    },
                                    child: const Icon(
                                      Icons.edit_document,
                                      size: 30,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDeleteCOnfirmationDialog(context, documentSnapshot["id"]);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.amber,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomTextWidgets(
                                text: 'Title : ${documentSnapshot["Title"]}',
                                clr: Colors.white,
                                fw: FontWeight.bold,
                                fz: 20,
                                lp: 1,
                              ),
                              CustomTextWidgets(
                                text: 'Price : ₹ ${documentSnapshot["Price : ₹"]}',
                                clr: Colors.amber,
                                fw: FontWeight.w600,
                                fz: 15,
                                lp: 1,
                              ),
                              CustomTextWidgets(
                                text: 'Aouthor : ${documentSnapshot["Aouthor"]}',
                                clr: Colors.white,
                                fw: FontWeight.bold,
                                fz: 15,
                                lp: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
      stream: bookStream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.amber,
        title: const CustomTextWidgets(
          text: "Book Stash",
          clr: Colors.black,
          fw: FontWeight.bold,
          fz: 20,
          lp: 1,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                AuthClassHelper.logout();
                Message.show(msg: "Loging Out....");
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: const Icon(
                Icons.lock,
                size: 20,
                color: Colors.black,
              ))
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: allBooksInfo(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 20,
            weight: 800,
            color: Colors.amber,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Books(),
              ),
            );
          }),
    );
  }

  Future editBook(String id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextWidgets(
                    text: "Edit a book",
                    clr: Colors.black,
                    fw: FontWeight.bold,
                    fz: 20,
                    lp: 1,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.cancel,
                        size: 20,
                        color: Colors.black,
                      )),
                ],
              ),
              const Divider(
                color: Colors.black,
                height: 2,
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
                    padding: const EdgeInsets.only(left: 15),
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
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
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
                    padding: const EdgeInsets.only(left: 15),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton.icon(
                          onPressed: () async {
                            Map<String, dynamic> updateDetails = {
                              "Title": titleControll.text,
                              "Price : ₹": priceControll.text,
                              "Aouthor": authorControll.text,
                              "id": id,
                            };
                            await DataBaseHelper().updateBook(id, updateDetails).then((value) {
                              Message.show(msg: "Successfully Updated !");
                            });
                          },
                          label: const CustomTextWidgets(
                            text: "Update",
                            clr: Colors.black,
                            fw: FontWeight.bold,
                            fz: 15,
                            lp: 1,
                          ),
                          icon: const Icon(
                            Icons.update,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: const CustomTextWidgets(
                            text: "Delete",
                            clr: Colors.black,
                            fw: FontWeight.bold,
                            fz: 15,
                            lp: 1,
                          ),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
