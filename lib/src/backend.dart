import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/backend_page.dart';
import 'package:tab_manager/src/components/amplify_configuration_storage.dart';
import 'package:tab_manager/models/ModelProvider.dart';

class BackendProvider extends StatefulWidget {
  const BackendProvider({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => BackendState();
}

class BackendState extends State<BackendProvider> {
  bool configStatus = false;

  static bool networkStatus = false;
  static bool outboxStatus = false;

  @override
  void initState() {
    super.initState();

    if (!Amplify.isConfigured) {
      AmplifyConfigurationStorage().readConfig().then((String value) {
        _setupAmplify(value);
      });
    }
  }

  void _setupAmplify(amplifyConfig) {
    if (amplifyConfig != '{}') {
      Amplify.addPlugins([
        // AmplifyAuthCognito(),
        // AmplifyAPI(),
      ]);
      configStatus = true;
    }

    if (configStatus) {
      Amplify.addPlugin(
          AmplifyDataStore(modelProvider: ModelProvider.instance));

      _configureAmplify(amplifyConfig);
      _subscribeAmplify();
    }
  }

  void _configureAmplify(amplifyConfig) async {
    try {
      await Amplify.configure(amplifyConfig);
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify...");
    }
  }

  void _subscribeAmplify() {
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
  }

  void stateRebuild(bool value) {
    configStatus = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (configStatus) {
      return widget.child;
    }
    return MaterialApp(
      title: 'TabManager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: BackendPage(refreshWith: stateRebuild),
    );
  }
}
