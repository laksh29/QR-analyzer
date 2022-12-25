import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:url_launcher/url_launcher.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // to make sure hot reload works we need to pause the camera in android and resume the camera in IOS

  @override
  void resemble() {
    super.reassemble();
    if (Device.get().isAndroid) {
      controller!.pauseCamera();
    } else if (Device.get().isIos) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      print(result!.code);
      // controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner")),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          flex: 5,
          child: Stack(children: [
            buildQrView(context),
            Positioned(
                bottom: 0,
                right: MediaQuery.of(context).size.width / 2.8,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controller!.resumeCamera();
                      buildQrView(context);
                    });
                  },
                  child: const Text("Scan Again!"),
                ))
          ]),
        ),
        Expanded(
            child: Center(
          child: (result != null)
              ? RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Data: ",
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: "${result!.code}",
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url = Uri.parse(result!.code.toString());
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  TextSpan(
                                      text: result!.code,
                                      style:
                                          const TextStyle(color: Colors.black));
                                }
                              })
                      ]))
              : const Text("Scan a code"),
        )),
      ]),
    );
  }

  QRView buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 15,
          borderColor: Colors.teal,
          cutOutSize: MediaQuery.of(context).size.width * 0.8),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
