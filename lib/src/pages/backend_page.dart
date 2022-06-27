import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:tab_manager/src/pages/code_scan_page.dart';
import 'package:tab_manager/src/pages/qr_scan_page.dart';
import 'package:tab_manager/src/components/amplify_configuration_storage.dart';

class BackendPage extends StatefulWidget {
  const BackendPage({Key? key, required this.refresh}) : super(key: key);

  final ValueChanged<String> refresh;

  @override
  State<BackendPage> createState() => _BackendPageState();
}

class _BackendPageState extends State<BackendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have no backend yet. Please add one!',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _storeConfiguration(context, method: 'qr');
              },
              icon: const Icon(
                Icons.qr_code_rounded,
                size: 24.0,
              ),
              label: const Text('Scan for configuration'),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                ' - OR - ',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const Text(
              'in case of trouble provide the connection string',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _storeConfiguration(context, method: 'type');
              },
              icon: const Icon(
                Icons.merge_type,
                size: 24.0,
              ),
              label: const Text('Add code'),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                ' - OR - ',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const Text(
              'continue without a cloud backend (for testing purposes)',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              onPressed: () {
                widget.refresh('{}');
              },
              icon: const Icon(
                Icons.fast_forward_rounded,
                size: 24.0,
              ),
              label: const Text('Skip this step for now'),
            ),
          ],
        ),
      ),
    );
  }

  void _storeConfiguration(BuildContext context, {required String method}) async {
    late String readData;
    if (method == 'qr') {
      readData = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRScanPage(key: Key('QRScanPage')),
      ));
    } else {
      readData = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CodeScanPage(key: Key('CodeScanPage')),
      ));
    }

    final decodedData = utf8.decode(
      GZipCodec().decode(base64.decode(readData)),
      allowMalformed: true,
    );

    var decodeSucceeded = false;
    try {
      json.decode(decodedData) as Map<String, dynamic>;
      decodeSucceeded = true;
    } on FormatException catch (e) {
      print('The provided string is not valid JSON');
    }

    if (decodeSucceeded) {
      // TODO: In case of Debug Mode play session, clear local datastore before add backend
      AmplifyConfigurationStorage()
          .writeConfig(decodedData)
          .whenComplete(() => Phoenix.rebirth(context));
    }
  }
}
