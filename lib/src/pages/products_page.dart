import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/product_repository.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: productsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ProductRepository.addProduct();
          });
        },
        tooltip: 'add Product',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget productsWidget() {
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
