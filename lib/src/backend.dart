import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/backend_page.dart';

class BackendProvider extends StatefulWidget {
  const BackendProvider({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => BackendState();
}

class BackendState extends State<BackendProvider> {
  bool configStatus = false;

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
