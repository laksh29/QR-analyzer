import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  // initializing
  Barcode? result;
  QRViewController? controller;
  final qrKey = GlobalKey(debugLabel: 'QR');

// controller
  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }

  @override
  void reassemble() {
    super.reassemble();

    if (Device.get().isAndroid) {
      controller!.pauseCamera();
    } else if (Device.get().isIos) {
      controller!.resumeCamera();
    }
  }

// reading qr
  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      print(result!.code);
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      body: Stack(children: [
        // qr view
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderWidth: 10,
              borderLength: 20,
              borderRadius: 15,
              borderColor: Colors.teal,
              cutOutSize: MediaQuery.of(context).size.width * 0.8),
        ),
        Positioned(
            bottom: 200,
            right: 140,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  controller!.resumeCamera();
                });
              },
              child: const Text("Scan Again !"),
            ))
      ]),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
