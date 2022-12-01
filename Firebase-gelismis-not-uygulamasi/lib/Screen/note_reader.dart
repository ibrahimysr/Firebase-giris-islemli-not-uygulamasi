import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/style/style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);

  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate =
        "${dateParse.day}-${dateParse.month}-${dateParse.year} ${dateParse.hour}:${dateParse.minute}";

    return formattedDate;
  }

  deleteData(id) async {
    await FirebaseFirestore.instance.collection("Notes").doc(id).delete();
    Navigator.pop(context);
  }

  updateUser(id) async {
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(id)
        .update({
          "notes_title": _NoteDetail.text,
          "creation_date": getCurrentDate(),
          "note_content": _TitleDetail.text,
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }

  TextEditingController _NoteDetail = TextEditingController();
  TextEditingController _TitleDetail = TextEditingController();

  @override
  void initState() {
    _NoteDetail.text = widget.doc["note_content"];
    _TitleDetail.text = widget.doc["notes_title"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc["color_id"];
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title:const  Text(
          "Not Detayı",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Appstyle.cardsColor[color_id],
        elevation: 0.0,
        actions: [
          PopupMenuButton(
              color: Appstyle.cardsColor[color_id],
              onSelected: (value) {
                if (value == 1) {
                  updateUser(widget.doc.id);
                }
                if (value == 2) {
                  deleteData(widget.doc.id);
                }
              },
              itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text(
                        'Güncelle',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text(
                        'Sil',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _TitleDetail,
              style: Appstyle.mainTitle,
              decoration:const  InputDecoration(
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Tarih:${widget.doc["creation_date"]}",
              style: Appstyle.dateTitle,
            ),
            const SizedBox(
              height: 28,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _NoteDetail,
              style: Appstyle.mainContent,
              decoration:const  InputDecoration(
                border: InputBorder.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
