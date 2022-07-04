import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:tab_manager/models/Product.dart';
import 'package:tab_manager/models/Event.dart';

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

  static Stream<QuerySnapshot<Product>> getProductsStreamByEvent(Event event) {
    return Amplify.DataStore.observeQuery(
      Product.classType,
      where: Product.EVENT.eq(event.id),
      sortBy: [Product.NAME.ascending()],
    );
  }
}
