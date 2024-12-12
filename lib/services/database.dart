import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseHelper{

  Future addBookDetails(Map<String , dynamic > bookMapInfo , id)async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).set(bookMapInfo);
  }

  //add all books

  Future<Stream <QuerySnapshot>> getAllbookInfo() async{
    return await FirebaseFirestore.instance.collection("Books").snapshots();
  }


  //update book

  Future updateBook(String id, Map<String,dynamic> updateDetails)async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).update(updateDetails);
  }

  //Delete 

  Future deleteBook(String id) async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).delete();
  }
}