import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/models/Event.dart';
import 'package:tab_manager/models/Product.dart';
import 'package:tab_manager/repositories/product_repository.dart';

class AddConsumptionPage extends StatefulWidget {
  const AddConsumptionPage({
    Key? key,
    required this.event,
    required this.undo,
  }) : super(key: key);

  final Event event;
  final VoidCallback undo;

  @override
  State<AddConsumptionPage> createState() => _AddConsumptionPageState();
}

class _AddConsumptionPageState extends State<AddConsumptionPage> {
  List<Product> _products = [];
  bool productSynced = false;
  late Stream<QuerySnapshot<Product>> productStream;

  @override
  void initState() {
    super.initState();
    productStream = ProductRepository.getProductsStreamByEvent(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Consumption')),
      body: indexWidget(),
    );
  }

  Widget indexWidget() {
    productStream.listen((QuerySnapshot<Product> snapshot) {
      if (mounted) {
        setState(() {
          _products = snapshot.items;
          productSynced = snapshot.isSynced;
        });
      }
    });

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        Product product = _products[index];
        return ListTile(
          title: Text('${product.name} - ${product.unit_price} coin'),
          // subtitle: Text("$stockSum in stock ${String.fromCharCode(0x00B7)}"),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Center(child: Icon(Icons.wine_bar_rounded)),
            ],
          ),
          onTap: () {
            final snackBar = SnackBar(
              content: Text('Yay! 1 ${product.name} added!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  widget.undo();
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            // TODO: a half-second wait mechanism to aggregate user action
            Navigator.pop(context, product);
          },
        );
      },
    );
  }
}
