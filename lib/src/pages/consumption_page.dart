import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tab_manager/models/Consumption.dart';
import 'package:tab_manager/repositories/consumption_repository.dart';

class ConsumptionPage extends StatefulWidget {
  const ConsumptionPage({Key? key, required this.ownerId}) : super(key: key);

  final String ownerId;

  @override
  State<ConsumptionPage> createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  List<Consumption> _consumptions = [];
  bool isSynced = false;
  late Stream<QuerySnapshot<Consumption>> stream;

  @override
  void initState() {
    super.initState();
    stream = ConsumptionRepository.getOwnConsumptionsStream(widget.ownerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consumption')),
      body: indexWidget(),
    );
  }

  Widget indexWidget() {
    stream.listen((QuerySnapshot<Consumption> snapshot) {
      if (mounted) {
        setState(() {
          _consumptions = snapshot.items;
          isSynced = snapshot.isSynced;
        });
      }
    });

    return ListView.builder(
      itemCount: _consumptions.length,
      itemBuilder: (context, index) {
        Consumption consumption = _consumptions[index];
        return ListTile(
          title: Text(
              '${consumption.product.name} - ${consumption.amount} pieces (${consumption.product.event.name})'),
          subtitle: Text(consumption.time.toString()),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Center(child: Icon(Icons.event)),
            ],
          ),
        );
      },
    );
  }
}
