import 'dart:typed_data';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class Generator extends StatefulWidget {
  const Generator({super.key});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator>
    with SingleTickerProviderStateMixin {
  bool color = false;
  Color colorPicker = const Color(0xff443a49);
  late AnimationController _animationController;
  final controller = TextEditingController();
  final saveController = TextEditingController();
  final shotController = ScreenshotController();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    super.initState();
  }

  void _handOnPressed() {
    setState(() {
      color = !color;
      color ? _animationController.forward() : _animationController.reverse();
    });
  }

  void changeColor(Color color) {
    setState(() {
      colorPicker = color;
    });
  }

// scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(
        title: const Text("Qr Generator"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      // body
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // color Picker
              // buildColorPicker(),
              buildSizedHeight(50.0),
              // generate QR
              buildQr(controller.text, colorPicker),
              buildSizedHeight(10.0),
              // Customise QR
              SizedBox(
                height: 40,
                width: 115,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/customize');
                    },
                    child: buildText("Customize QR")),
              ),
              buildSizedHeight(30.0),
              // Input Text Box
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: 400,
                child: TextField(
                  controller: controller,
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
                      ),
                    ),
                  ),
                ),
              ),
              // save file name input
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: 400,
                child: TextField(
                  controller: saveController,
                  decoration: InputDecoration(
                    hintText: "Enter the Name of the File (Optional)",
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ),
              buildSizedHeight(20.0),
              // buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // generate qr button
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: buildText("Generate QR")),
                  ),
                  const SizedBox(width: 20),
                  // save qr button
                  SizedBox(
                      height: 50,
                      width: 120,
                      child: ElevatedButton(
                          onPressed: () async {
                            final image =
                                await shotController.captureFromWidget(
                                    buildQr(controller.text, colorPicker),
                                    pixelRatio: 20);
                            if (image == null) return;
                            await saveImage(image);
                          },
                          child: buildText("Save QR")))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox buildSizedHeight(height) => SizedBox(height: height);

  AnimatedContainer buildColorPicker() {
    return AnimatedContainer(
      // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      width: 400,
      height: color == false ? 70 : 280,
      decoration: BoxDecoration(
          color: Colors.cyan, borderRadius: BorderRadius.circular(0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  // color text
                  child: Text("COLOR :",
                      style: GoogleFonts.poppins(
                        textStyle: buildPoppinsW500(16.0),
                      )),
                ),
                const Spacer(),
                // color show case
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 30,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorPicker,
                  ),
                ),
                const Spacer(),
                // animated button menu - arrow
                IconButton(
                  onPressed: () {
                    _handOnPressed();
                  },
                  icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      color: Colors.white,
                      progress: _animationController),
                  // splashColor: Colors.transparent,
                )
              ],
            ),
            // Color Drop Down Menu
            color == true
                ? SizedBox(
                    height: 200,
                    child: MaterialPicker(
                      pickerColor: colorPicker,
                      onColorChanged: changeColor,
                      enableLabel: true,
                      portraitOnly: true,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  QrImage buildQr(text, color) {
    return QrImage(
      data: text,
      version: QrVersions.auto,
      size: 200,
      foregroundColor: color,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
      semanticsLabel: "laksh.devsigner",
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(8),
    );
  }

  Text buildText(word) {
    return Text(
      "$word",
      style: GoogleFonts.poppins(),
    );
  }

  TextStyle buildPoppinsW500(size) {
    return TextStyle(
        color: Colors.white, fontSize: size, fontWeight: FontWeight.w500);
  }

  Future saveImage(Uint8List image) async {
    await [Permission.storage].request();
    // final time = DateTime.now();
    // // .replaceAll('.', "_")
    // // .replaceAll(":", "_");
    // final name = 'Scanner_$time';
    final result =
        await ImageGallerySaver.saveImage(image, name: saveController.text);
    return result['filePath'];
  }
}
