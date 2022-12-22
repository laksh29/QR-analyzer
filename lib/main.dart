import 'package:flutter/material.dart';
import 'package:qr_analyzer/decoration.dart';
import 'package:qr_analyzer/generator.dart';
import 'package:qr_analyzer/scan.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';55
// import 'package:qrcode_example/qr_provider.dart';
void main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const Generator(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const QrScanner(),
      },
    );
  }
}
