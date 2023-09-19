import 'package:flutter/material.dart';
import 'package:messegeme/screens/chat_sc.dart';
import 'package:messegeme/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RigstSec extends StatefulWidget {
  static const String scRoute = "rigestsc";

  const RigstSec({Key? key}) : super(key: key);

  @override
  State<RigstSec> createState() => _RigstSecState();
}

class _RigstSecState extends State<RigstSec> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String pass;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "images/1.png",
                  height: 180,
                ),
                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintText: ("Entre Your Email"),
                    // border: OutlineInputBorder(
                    //     borderSide: BorderSide(width: 2, color: Colors.red),
                    //     borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF324A5E)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFF1543F)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 13),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    pass = value;
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintText: ("Entre Your Password"),
                    // border: OutlineInputBorder(
                    //     borderSide: BorderSide(width: 2, color: Colors.red),
                    //     borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF324A5E)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFF1543F)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 15),
                Mybutton(
                    culur: const Color(0xFFF1543F),
                    title: "OK",
                    onpressed: () async {
                      try {
                        print(email);
                        print(pass);
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: pass);
                        Navigator.pushNamed(context, ChatSc.scChat);
                      } catch (e) {
                        print(e);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
