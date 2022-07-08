import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import "package:collection/collection.dart";
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

    var consumptionsByProduct =
        groupBy(_consumptions, (Consumption obj) => obj.product.name);

    return ListView.builder(
      itemCount: consumptionsByProduct.length,
      itemBuilder: (context, index) {
        String productName = consumptionsByProduct.keys.toList()[index];
        int? consumptionSum = consumptionsByProduct[productName]
            ?.fold(0, (p, c) => p! + c.amount);
        int? priceSum = consumptionsByProduct[productName]
            ?.fold(0, (p, c) => p! + c.product.unit_price);
        String? eventName =
            consumptionsByProduct[productName]?.first.product.event.name;

        return ListTile(
          title: Text('$productName - $consumptionSum pieces'),
          subtitle: Text("$priceSum coins ($eventName)"),
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
