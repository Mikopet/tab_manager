import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildQrView(context),
              Positioned(bottom: 10, child: _buildResult()),
              Positioned(top: 10, child: _buildControlButtons())
            ],
          ),
        ),
      );

  Widget _buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white12,
        ),
        child: Text(
          result != null ? 'Got something!\n${result!.code}' : 'Scan a code',
          maxLines: 3,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      );

  Widget _buildControlButtons() => IconButton(
        icon: FutureBuilder<bool?>(
          future: controller?.getFlashStatus(),
          builder: (c, snapshot) {
            if (snapshot.data != null) {
              return Icon(
                snapshot.data! ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
              );
            } else {
              return Container();
            }
          },
        ),
        onPressed: () async {
          try {
            await controller?.toggleFlash();
          } on CameraException {
            log('no flash here');
          }
          setState(() {});
        },
      );

  Widget _buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.secondary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      );

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((scanData) => setState(() => result = scanData));
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
