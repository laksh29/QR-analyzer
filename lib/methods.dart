import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

TextStyle buildPoppinsW500(size) {
    return TextStyle(
        color: Colors.white, fontSize: size, fontWeight: FontWeight.w500);
  }

    Text buildText(word) {
    return Text(
      "$word",
      style: GoogleFonts.poppins(),
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

 