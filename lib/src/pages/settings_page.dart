import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tab_manager/src/pages/qr_scan_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRScanPage(),
                ));
              },
              child: const Text('Add server'),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Amplify.DataStore.clear();
              },
              child: const Text('Delete local data'),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
