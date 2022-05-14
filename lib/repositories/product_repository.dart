import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:tab_manager/models/Product.dart';

class ProductRepository {
  // TODO: create valid logic
  static addProduct() async {
    final now = TemporalTime.now()
        .format()
        .replaceAll(RegExp(r'[^0-9]'), '')
        .substring(0, 6);

    try {
      Product product = Product(
        name: 'Product #$now',
      );
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
