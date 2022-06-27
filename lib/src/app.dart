import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/home_page.dart';
import 'package:tab_manager/src/components/theme.dart';

class TabManager extends StatefulWidget {
  const TabManager({Key? key, required this.authenticator}) : super(key: key);

  final bool authenticator;

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<TabManager> {
  @override
  Widget build(BuildContext context) {
    if (widget.authenticator) {
      return Authenticator(
        key: const Key('Authenticator'),
        child: MaterialApp(
          builder: Authenticator.builder(),
          title: 'TabManager',
          theme: appTheme,
          home: const HomePage(key: Key('HomePage'), title: 'TabManager'),
        ),
      );
    }

    return MaterialApp(
      title: 'TabManager',
      theme: appTheme,
      home: const HomePage(
        key: Key('HomePage'),
        title: 'TabManager Debug',
      ),
    );
  }
}
