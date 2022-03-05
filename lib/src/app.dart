import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/home_page.dart';
import 'package:tab_manager/src/components/theme.dart';
import 'package:tab_manager/models/ModelProvider.dart';

import '../amplifyconfiguration.dart';

class TabManager extends StatefulWidget {
  const TabManager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<TabManager> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  static bool networkStatus = false;
  static bool outboxStatus = false;

  void _configureAmplify() async {
    Amplify.Hub.listen([HubChannel.DataStore], (hubEvent) {
      if (hubEvent.eventName == 'networkStatus') {
        setState(() {
          networkStatus = hubEvent.payload as bool; // TODO: .active
        });
      }
      if (hubEvent.eventName == 'outboxStatus') {
        setState(() {
          outboxStatus = hubEvent.payload as bool; // TODO: .isEmpty
        });
      }
    });

    Amplify.addPlugins([
      AmplifyDataStore(modelProvider: ModelProvider.instance),
      // AmplifyAPI(),
    ]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify...");
    }
    // TODO: put this under a button inside a settings menu
    Amplify.DataStore.clear();
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
