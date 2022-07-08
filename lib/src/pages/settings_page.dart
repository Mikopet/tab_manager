import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tab_manager/src/components/amplify_configuration_storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.userId}) : super(key: key);

  final String userId;

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
                Amplify.DataStore.clear();
              },
              child: const Text('Delete local data'),
              style: ElevatedButton.styleFrom(primary: Colors.amber),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                AmplifyConfigurationStorage()
                    .deleteConfig()
                    .whenComplete(() => Phoenix.rebirth(context));
              },
              child: const Text('Delete backend config'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Amplify.Auth.signOut();
                Phoenix.rebirth(context);
              },
              child: const Text('Sign Out'),
              style: ElevatedButton.styleFrom(primary: Colors.orange),
            ),
          ),
          Center(
            child: Column(children: <Widget>[
              const Text('USER ID:'),
              Text(widget.userId),
            ]),
          )
        ],
      ),
    );
  }
}
