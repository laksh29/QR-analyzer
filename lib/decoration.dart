import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_analyzer/methods.dart';
import 'package:qr_flutter/qr_flutter.dart';




class Customize extends StatefulWidget {
  const Customize({super.key});

  @override
  State<Customize> createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize>
    with SingleTickerProviderStateMixin {
  bool color = false;
  Color colorpicker = const Color(0xff443a49);
  late AnimationController _animationController;

  void changeColor(Color color) {
    setState(() {
      colorpicker = color;
    });
  }

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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [colorPicker()],
            ),
          ],
        ));
  }

  AnimatedContainer colorPicker() {
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
                    color: colorpicker,
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
                      pickerColor: colorpicker,
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
}

TextStyle buildPoppinsW500(size) {
  return TextStyle(
      color: Colors.white, fontSize: size, fontWeight: FontWeight.w500);
}
