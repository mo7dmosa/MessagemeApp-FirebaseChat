import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messegeme/screens/chat_sc.dart';
import 'package:messegeme/screens/login_sc.dart';
import 'package:messegeme/screens/rigest_sc.dart';
import 'screens/wellcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  FirebaseAuth _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessegeME',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _auth.currentUser != null ? ChatSc.scChat : "Wellcome",
      routes: {
        RigstSec.scRoute: (context) => const RigstSec(),
        LoginSc.scLogin: (context) => LoginSc(),
        "Wellcome": (context) => const WellcomeSec(),
        ChatSc.scChat: (context) => const ChatSc(),
      },
    );
  }
}
