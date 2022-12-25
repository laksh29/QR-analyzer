import 'package:flutter/material.dart';
import 'package:qr_analyzer/generator.dart';
import 'package:qr_analyzer/scan.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int count = 0;
  final screens = <StatefulWidget>[const Generator(), const Scanner()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[count],
      extendBodyBehindAppBar: true,
      // extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: count,
        onTap: (index) => setState(() {
          count = index;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_2_outlined), label: "QR Generator"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_outlined), label: "QR Scanner")
        ],
        selectedItemColor: Colors.teal,
      ),
    );
  }
}
