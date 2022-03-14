import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/src/components/amplify_configuration_storage.dart';
import 'package:tab_manager/src/pages/home_page.dart';
import 'package:tab_manager/src/components/theme.dart';
import 'package:tab_manager/models/ModelProvider.dart';

class TabManager extends StatefulWidget {
  const TabManager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<TabManager> {
  static bool networkStatus = false;
  static bool outboxStatus = false;

  @override
  void initState() {
    super.initState();
    AmplifyConfigurationStorage().readConfig().then((String value) {
      if (value.isNotEmpty) {
        _configureAmplify(value);
      }
    });
  }

  void _configureAmplify(amplifyConfig) async {
    Amplify.addPlugins([
      AmplifyDataStore(modelProvider: ModelProvider.instance),
      AmplifyAuthCognito(),
      // AmplifyAPI(),
    ]);
    try {
      await Amplify.configure(amplifyConfig);

      Amplify.Hub.listen([HubChannel.DataStore], (hubEvent) {
        if (hubEvent.eventName == 'networkStatus') {
          setState(() {
            // networkStatus = hubEvent.payload.active
          });
        }
        if (hubEvent.eventName == 'outboxStatus') {
          setState(() {
            // outboxStatus = hubEvent.payload.isEmpty
          });
        }
      });
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabManager',
      theme: appTheme,
      home: const HomePage(title: 'TabManager'),
    );
  }
}
