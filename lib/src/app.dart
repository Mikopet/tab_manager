import 'package:flutter/material.dart';
import 'package:tab_manager/src/pages/home_page.dart';

class TabManager extends StatelessWidget {
  const TabManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabManager',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const HomePage(title: 'TabManager'),
    );
  }
}
