import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:tab_manager/models/Stock.dart';

class StockRepository {
  static addStock(Stock stock) async {
    try {
      await Amplify.DataStore.save(stock);
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot<Stock>> getStocksStream() {
    return Amplify.DataStore.observeQuery(
      Stock.classType,
      sortBy: [Stock.SUPPLY_TIME.descending()],
    );
  }
}
