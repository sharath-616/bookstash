  import 'package:bookstash/services/database.dart';
import 'package:bookstash/utilities/custom_text_widgets.dart';
import 'package:flutter/material.dart';

void showDeleteCOnfirmationDialog(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const CustomTextWidgets(text: "Confirm Deletion"),
            content: const Text('Are You Sure to delete'),
            actions: [
              Expanded(
                child: TextButton(
                    onPressed: () async {
                      await DataBaseHelper().deleteBook(id);
                      Navigator.pop(context);
                    },
                    child: const CustomTextWidgets(text: 'Yes')),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const CustomTextWidgets(text: 'No')),
              ),
            ],
          );
        });
  }