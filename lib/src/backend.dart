import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/src/app.dart';
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
  StreamSubscription<HubEvent>? stream;
  static bool networkStatus = false;
  static bool outboxStatus = false;
  String _amplifyConfig = '{}';

  @override
  void initState() {
    super.initState();
    AmplifyConfigurationStorage().readConfig().then((String amplifyConfig) {
      setState(() {
        _amplifyConfig = amplifyConfig;
      });

      if (amplifyConfig != '{}') {
        _configureAmplify(amplifyConfig);
      }
    });
  }

  void _setupAmplify(String amplifyConfig) {
    if (amplifyConfig != '{}') {
      Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyAPI(modelProvider: ModelProvider.instance),
      ]);
    }

    Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));
  }

  void _configureAmplify(amplifyConfig) async {
    try {
      if (!Amplify.isConfigured) {
        _setupAmplify(amplifyConfig);
        await Amplify.configure(amplifyConfig).whenComplete(() {
          setState(() {
            _subscribeAmplify();
          });
        });
      }
    } catch (e) {
      print("Amplify config error: $e");
    }
  }

  void _subscribeAmplify() {
    stream = Amplify.Hub.listen([HubChannel.DataStore], (hubEvent) {
      if (hubEvent.eventName == 'networkStatus') {
        setState(() {
          final status = hubEvent.payload as NetworkStatusEvent?;
          networkStatus = status?.active ?? false;
        });
      }
      if (hubEvent.eventName == 'outboxStatus') {
        setState(() {
          final status = hubEvent.payload as OutboxStatusEvent?;
          outboxStatus = status?.isEmpty ?? false;
        });
      }
    });
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: perhaps a FutureBuilder with a CircularLoader is valid here
    // https://docs.amplify.aws/start/getting-started/integrate/q/integration/flutter/#configure-amplify
    // this has an idea
    if (Amplify.isConfigured) {
      if (_amplifyConfig != '{}') {
        // TODO: this is not dynamic, need some refactor
        return const TabManager(authenticator: true);
      }

      return widget.child;
    }

    return MaterialApp(
      title: 'TabManager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: BackendPage(
        key: const Key('BackendPage'),
        refresh: _configureAmplify,
      ),
    );
  }
}
