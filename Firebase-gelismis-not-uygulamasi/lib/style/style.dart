

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appstyle {
  static Color bgColor = const Color(0xffe2e2ff);
  static Color ButtonColor = Colors.indigo.withOpacity(0.2);

  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blueGrey.shade100,
    Colors.blue.shade100,
    Colors.lightBlue.shade100,
    Colors.brown.shade100,
    Colors.lime.shade100,
    Colors.indigo.shade100
  ];

  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle mainContent =
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.normal);
  static TextStyle dateTitle =
      GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500);
  static TextStyle LoginContent = GoogleFonts.nunito(
      color: Colors.white, fontSize: 30, fontWeight: FontWeight.normal);
}
