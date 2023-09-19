import 'package:flutter/material.dart';
import 'package:messegeme/screens/login_sc.dart';
import 'package:messegeme/screens/rigest_sc.dart';
import 'package:messegeme/widgets/my_button.dart';

class WellcomeSec extends StatefulWidget {
  const WellcomeSec({Key? key}) : super(key: key);

  @override
  State<WellcomeSec> createState() => _WellcomeSecState();
}

class _WellcomeSecState extends State<WellcomeSec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                "images/1.png",
                height: 120,
              ),
              const Text(
                "MessegeMe",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Color(0xFFF1543F),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Mybutton(
                culur: const Color(0xFF324A5E), //ازرق
                title: ("Sign in"),
                onpressed: () {
                  Navigator.pushNamed(context, LoginSc.scLogin);
                },
              ),
              Mybutton(
                culur: const Color(0xFFF1543F), // كرميدي
                title: ("Rigester"),
                onpressed: () {
                  Navigator.pushNamed(context, RigstSec.scRoute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
