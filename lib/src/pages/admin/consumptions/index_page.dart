import 'package:amplify_datastore/amplify_datastore.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/consumption_repository.dart';

class ConsumptionIndexPage extends StatefulWidget {
  const ConsumptionIndexPage({Key? key}) : super(key: key);

  @override
  State<ConsumptionIndexPage> createState() => _ConsumptionIndexPageState();
}

class _ConsumptionIndexPageState extends State<ConsumptionIndexPage> {
  List<Consumption> _consumptions = [];
  bool isSynced = false;
  Stream<QuerySnapshot<Consumption>> stream =
      ConsumptionRepository.getConsumptionsStream();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consumptions')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: indexWidget()),
        ],
      ),
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

    var consumptionsByUsers =
        groupBy(_consumptions, (Consumption obj) => obj.owner);

    return ListView.builder(
      itemCount: consumptionsByUsers.length,
      itemBuilder: (context, index) {
        String userId = consumptionsByUsers.keys.toList()[index];
        int? consumptionSum = consumptionsByUsers[userId]
            ?.fold(0, (p, c) => p! + c.product.unit_price);

        return userId.contains(searchString)
            ? ListTile(
                title: Text(userId),
                subtitle: Text("$consumptionSum coin"),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Center(child: Icon(Icons.monetization_on)),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
