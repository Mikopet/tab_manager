import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/product_repository.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({Key? key}) : super(key: key);

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final _nameController = TextEditingController();

  Future<void> _save() async {
    String name = _nameController.text;

    Product product = Product(
      name: name,
    );

    await ProductRepository.addProduct(product);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: addWidget(),
    );
  }

  Widget addWidget() => Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration:
                      const InputDecoration(filled: true, labelText: 'Name')),
              ElevatedButton(onPressed: _save, child: const Text('Save'))
            ],
          ),
        ),
      );
}
