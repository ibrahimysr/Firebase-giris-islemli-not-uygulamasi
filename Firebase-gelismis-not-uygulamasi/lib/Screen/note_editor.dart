import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/style/style.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit({Key? key}) : super(key: key);

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  int Color_id = Random().nextInt(Appstyle.cardsColor.length);

  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate =
        "${dateParse.day}-${dateParse.month}-${dateParse.year} ${dateParse.hour}:${dateParse.minute}";

    return formattedDate;
  }

  final  _TitleController = TextEditingController();

  final  _NoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[Color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[Color_id],
        title: const Text(
          "Yeni Not Oluşturunuz",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _TitleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Not Başlıgı"),
              style: Appstyle.mainTitle,
            ),
           const  SizedBox(
              height: 8,
            ),
            Text(
              "Tarih:${getCurrentDate()}",
              style: Appstyle.dateTitle,
            ),
           const  SizedBox(
              height: 28,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _NoteController,
              decoration:const  InputDecoration(
                  border: InputBorder.none, hintText: "Ana Not"),
              style: Appstyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").add({
            "notes_title": _TitleController.text,
            "creation_date": getCurrentDate(),
            "note_content": _NoteController.text,
            "color_id": Color_id
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Yeni Not OLuşturulurken Hata Oluştu $error"));
        },
        backgroundColor: Appstyle.ButtonColor,
        child: const Icon(Icons.save),
      ),
    );
  }
}
