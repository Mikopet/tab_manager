import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tab_manager/src/components/amplify_configuration_storage.dart';
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
                _storeConfiguration(context);
              },
              child: const Text('Add server'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Amplify.DataStore.clear();
              },
              child: const Text('Delete local data'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _storeConfiguration(BuildContext context) async {
    final String qrData = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const QRScanPage(),
    ));

    // TODO: validation
    AmplifyConfigurationStorage().writeConfig(qrData);
    Phoenix.rebirth(context);
  }
}
