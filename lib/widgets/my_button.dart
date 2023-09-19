import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  const Mybutton(
      {required this.culur, required this.title, required this.onpressed});

  final Color culur;
  final String title;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: culur,
        borderRadius: BorderRadius.circular(10),
        elevation: 3,
        child: MaterialButton(
          onPressed: onpressed,
          height: 48,
          minWidth: 350,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
