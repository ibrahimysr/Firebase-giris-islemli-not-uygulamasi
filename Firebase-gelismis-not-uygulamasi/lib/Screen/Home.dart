import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/Screen/loginpage.dart';
import 'package:login/Screen/note_editor.dart';
import 'package:login/Screen/note_reader.dart';
import 'package:login/style/style.dart';
import 'package:login/widget/note_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut().then((value) => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LoginPage()))
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notlarınız",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    PopupMenuButton(
                        icon:const  Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        color: Appstyle.ButtonColor,
                        onSelected: (value) {
                          if (value == 1) {
                            _signOut();
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text(
                                  'Çıkış Yap',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ]),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Notes")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          children: snapshot.data!.docs
                              .map((note) => Notecard(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NoteReaderScreen(note)));
                                  }, note))
                              .toList(),
                        );
                      }
                      return Text(
                        "Notunuz Yok",
                        style: GoogleFonts.nunito(color: Colors.white),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Appstyle.ButtonColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>const  NoteEdit()));
          },
          label:const  Text("Not Ekle"),
          icon:const  Icon(Icons.add),
        ),
      ),
    );
  }
}
