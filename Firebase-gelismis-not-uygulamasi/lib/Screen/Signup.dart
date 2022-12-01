import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/style/style.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _EmailController = TextEditingController();
  final _PasswordController = TextEditingController();

  Signup() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _EmailController.text, password: _PasswordController.text)
        .then((value) => {Navigator.pop(context)});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             const  SizedBox(
                height: 100,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Hoşgeldiniz",
                  style: Appstyle.LoginContent,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: TextField(
                        controller: _EmailController,
                        style: const TextStyle(color: Colors.white),
                        decoration:const InputDecoration(
                            icon:
                                Icon(Icons.email_outlined, color: Colors.white),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        obscureText: true,
                        controller: _PasswordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.white),
                            border: InputBorder.none,
                            hintText: "Şifre",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("tıklama");
                  Signup();
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Appstyle.ButtonColor,
                  ),
                  child: const Center(
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
