import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tab_manager/src/components/amplify_configuration_storage.dart';

class ConsumptionPage extends StatefulWidget {
  const ConsumptionPage({Key? key}) : super(key: key);

  @override
  State<ConsumptionPage> createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consumption')),
      body: Column(
        children: const [],
      ),
    );
  }
}
