import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:tab_manager/models/Product.dart';

class ProductRepository {
  static addProduct(Product product) async {
    try {
      await Amplify.DataStore.save(product);
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Product>> getProducts() async {
    List<Product> products = await Amplify.DataStore.query(
      Product.classType,
    );

    return products;
  }
}
