import 'package:amplify_datastore/amplify_datastore.dart';
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

  static Stream<QuerySnapshot<Product>> getProductsStream() {
    return Amplify.DataStore.observeQuery(
      Product.classType,
      sortBy: [Product.NAME.ascending()],
    );
  }
}
