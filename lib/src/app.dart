import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tab_manager/src/pages/home_page.dart';
import 'package:tab_manager/src/theme.dart';

import '../amplifyconfiguration.dart';
import '../models/ModelProvider.dart';

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

  void _configureAmplify() async {
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
