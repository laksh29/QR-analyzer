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
      // colorPicker = color;
    });
  }

// scaffold
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appbar
      appBar: AppBar(
        title: const Text("QR Analyzer"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      // body
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Width $width x Height $height"),
              // color Picker
              // buildColorPicker(),
              buildSizedHeight(width / 7.68),
              // generate QR
              buildQr(controller.text, colorPicker),
              buildSizedHeight(width / 38.4),
              // Customise QR
              // SizedBox(
              //   height: width / 9.6,
              //   width: width / 3.33,
              //   child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.pushNamed(context, '/customize');
              //       },
              //       child: buildText("Customize QR", width / 38.4)),
              // ),
              buildSizedHeight(width / 12.8),
              // Input Text Box
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width / 32, vertical: width / 64.0),
                width: width / 0.96,
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
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              // save file name input
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width / 32.0, vertical: width / 64),
                width: width / 0.96,
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
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              buildSizedHeight(width / 19.2),
              // buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // generate qr button
                  SizedBox(
                    height: width / 7.68,
                    width: width / 3.2,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: buildText("Generate QR", width / 32)),
                  ),
                  SizedBox(width: width / 19.2),
                  // save qr button
                  SizedBox(
                      height: width / 7.68,
                      width: width / 3.2,
                      child: ElevatedButton(
                          onPressed: () async {
                            final image =
                                await shotController.captureFromWidget(
                                    buildQr(controller.text, colorPicker),
                                    pixelRatio: 20);
                            saveImage(image);
                            const snackBar = SnackBar(
                              content: Text('Image Saved'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: buildText("Save QR", width / 32))),
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

  Text buildText(word, fontSize) {
    return Text(
      "$word",
      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: fontSize)),
      // textAlign: TextAlign.center,
    );
  }

  TextStyle buildPoppinsW500(size) {
    return TextStyle(
        color: Colors.white, fontSize: size, fontWeight: FontWeight.w500);
  }

  Future saveImage(Uint8List image) async {
    await [Permission.storage].request();
    final result =
        await ImageGallerySaver.saveImage(image, name: saveController.text);
    return result['filePath'];
  }

  
}
