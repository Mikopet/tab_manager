import 'dart:developer';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/product_repository.dart';
import 'package:tab_manager/repositories/stock_repository.dart';

class StockAddPage extends StatefulWidget {
  const StockAddPage({Key? key}) : super(key: key);

  @override
  State<StockAddPage> createState() => _StockAddPageState();
}

class _StockAddPageState extends State<StockAddPage> {
  final _amountController = TextEditingController();
  final _supplyPriceController = TextEditingController();
  final _supplyTimeController =
      TextEditingController(text: TemporalDateTime.now().toString());

  late Product _selectedProduct;
  List<Product> _products = [];
  bool isSynced = false;
  Stream<QuerySnapshot<Product>> stream = ProductRepository.getProductsStream();

  Future<void> _save() async {
    int amount = int.parse(_amountController.text);
    int supplyPrice = int.parse(_supplyPriceController.text);
    TemporalDateTime supplyTime =
        TemporalDateTime.fromString(_supplyTimeController.text);

    Stock stock = Stock(
      amount: amount,
      supply_price: supplyPrice,
      supply_time: supplyTime,
      product: _selectedProduct,
    );

    await StockRepository.addStock(stock);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Stock')),
      body: addWidget(),
    );
  }

  Widget dropdown(BuildContext context) {
    stream.listen((QuerySnapshot<Product> snapshot) {
      setState(() {
        _products = snapshot.items;
        isSynced = snapshot.isSynced;
      });
    });

    return DropdownButtonFormField<Product>(
      // value: _products.first,
      hint: const Text('Product'),
      isExpanded: true,
      isDense: true,
      decoration: const InputDecoration(
        filled: true,
        labelText: 'Product',
        icon: Icon(Icons.wine_bar),
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 40),
      ),
      onChanged: (Product? value) {
        setState(() {
          _selectedProduct = value!;
        });
      },
      items: _products.map((Product p) {
        return DropdownMenuItem(
          value: p,
          child: ListTile(
            title: Text(p.name),
            subtitle: Text("${p.event.name}"),
          ),
        );
      }).toList(),
    );
  }

  Widget addWidget() => Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              dropdown(context),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Amount',
                  icon: Icon(Icons.batch_prediction),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], //
              ),
              TextFormField(
                controller: _supplyPriceController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Supply Price',
                  icon: Icon(Icons.price_change),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              TextFormField(
                controller: _supplyTimeController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Supply Time',
                  icon: Icon(Icons.punch_clock),
                ),
              ),
              ElevatedButton(onPressed: _save, child: const Text('Save'))
            ],
          ),
        ),
      );
}
