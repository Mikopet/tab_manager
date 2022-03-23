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
    _configureAmplify();
  }

  void _configureAmplify() async {
    late final String amplifyConfig;

    try {
      AmplifyConfigurationStorage().readConfig().then((String value) {
        amplifyConfig = value;

        Amplify.addPlugin(
            AmplifyDataStore(modelProvider: ModelProvider.instance));

        if (amplifyConfig != '{}') {
          Amplify.addPlugins([
            // AmplifyAuthCognito(),
            // AmplifyAPI(),
          ]);
          configStatus = true;
        }

        Amplify.configure(amplifyConfig);

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
      });
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify...");
    }
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
