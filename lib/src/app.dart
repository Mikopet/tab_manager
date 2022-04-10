import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/home_page.dart';
import 'package:tab_manager/src/components/theme.dart';

class TabManager extends StatefulWidget {
  const TabManager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<TabManager> {
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        title: 'TabManager',
        theme: appTheme,
        home: const HomePage(title: 'TabManager'),
      ),
    );
  }
}
