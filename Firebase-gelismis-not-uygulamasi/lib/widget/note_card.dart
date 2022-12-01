import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/style/style.dart';

Widget Notecard(Function()? ontap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding:const EdgeInsets.all(8.0),
      margin:const  EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Appstyle.cardsColor[doc["color_id"]],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["notes_title"],
            style: Appstyle.mainTitle,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            doc["creation_date"],
            style: Appstyle.dateTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            doc["note_content"],
            style: Appstyle.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
          
        ],
      ),
    ),
  );
}
