import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../admin/view.order.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return scannedBarcode == null
        ? Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                buildQrView(context),
                Positioned(
                  bottom: 10,
                  child: Text(
                    scannedBarcode != null
                        ? '${scannedBarcode!.code}'
                        : 'Scanning',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        : ViewOrderAdmin(userid: "${scannedBarcode!.code}");
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.amber,
        borderRadius: 10,
        borderWidth: 5,
        cutOutSize: MediaQuery.of(context).size.width * 0.80,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((Barcode event) {
      setState(() {
        result = event;
      });
    });
  }

  Barcode? get scannedBarcode => result;
}
