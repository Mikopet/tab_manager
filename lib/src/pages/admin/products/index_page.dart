import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/product_repository.dart';
import 'package:tab_manager/src/pages/admin/products/add_page.dart';

class ProductIndexPage extends StatefulWidget {
  const ProductIndexPage({Key? key}) : super(key: key);

  @override
  State<ProductIndexPage> createState() => _ProductIndexPageState();
}

class _ProductIndexPageState extends State<ProductIndexPage> {
  List<Product> _products = [];
  bool isSynced = false;
  Stream<QuerySnapshot<Product>> stream = ProductRepository.getProductsStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: indexWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => const ProductAddPage()));
        },
        tooltip: 'add Product',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget indexWidget() {
    stream.listen((QuerySnapshot<Product> snapshot) {
      setState(() {
        _products = snapshot.items;
        isSynced = snapshot.isSynced;
      });
    });

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        Product product = _products[index];
        return ListTile(
          title: Text('${product.name} - ${product.unit_price}'),
          // TODO: add currency
          subtitle:
              Text('${product.event.start_date} - ${product.event.end_date}'),
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
