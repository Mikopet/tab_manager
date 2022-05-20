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
    return FutureBuilder<List<Product>>(
      future: ProductRepository.getProducts(),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData ||
            snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(child: CircularProgressIndicator())),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Product product = snapshot.data![index];
            return ListTile(
              title: Text(product.name),
              //subtitle: Text('${product.start_date} - ${product.end_date}'),
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Center(child: Icon(Icons.wine_bar)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
