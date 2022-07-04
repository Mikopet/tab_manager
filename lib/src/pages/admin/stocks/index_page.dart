import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/stock_repository.dart';
import 'package:tab_manager/src/pages/admin/stocks/add_page.dart';

class StockIndexPage extends StatefulWidget {
  const StockIndexPage({Key? key}) : super(key: key);

  @override
  State<StockIndexPage> createState() => _StockIndexPageState();
}

class _StockIndexPageState extends State<StockIndexPage> {
  List<Stock> _stocks = [];
  bool isSynced = false;
  Stream<QuerySnapshot<Stock>> stream = StockRepository.getStocksStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stocks')),
      body: indexWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => const StockAddPage()));
        },
        tooltip: 'add Stock',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget indexWidget() {
    stream.listen((QuerySnapshot<Stock> snapshot) {
      if (mounted) {
        setState(() {
          _stocks = snapshot.items;
          isSynced = snapshot.isSynced;
        });
      }
    });

    return ListView.builder(
      itemCount: _stocks.length,
      itemBuilder: (context, index) {
        Stock stock = _stocks[index];

        // TODO: add warn symbols if no time and price is given
        return ListTile(
          title: Text("${stock.amount} ${stock.product.name}"),
          subtitle: Text(stock.product.event.name),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Center(child: Icon(Icons.batch_prediction)),
            ],
          ),
        );
      },
    );
  }
}
