import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrFlutter extends StatefulWidget {
  const QrFlutter({super.key});

  @override
  State<QrFlutter> createState() => _QrFlutterState();
}

class _QrFlutterState extends State<QrFlutter> {
final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Scanner"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: controller.text,
                size: 200,
              ),
              const SizedBox(height: 40),
              buildTextField(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) => TextField(
        controller: controller,
        style: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
        decoration: InputDecoration(
            hintText: "Enter the data",
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                )),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(
                  Icons.done,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ))),
      );
}





