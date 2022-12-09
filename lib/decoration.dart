import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customize extends StatefulWidget {
  const Customize({super.key});

  @override
  State<Customize> createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Sorry! Yet to be build 😢",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "! Click the above text to go back !",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
