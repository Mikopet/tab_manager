import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:tab_manager/models/Consumption.dart';

class ConsumptionRepository {
  static addConsumption(Consumption consumption) async {
    try {
      await Amplify.DataStore.save(consumption);
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot<Consumption>> getConsumptionsStream() {
    return Amplify.DataStore.observeQuery(
      Consumption.classType,
      sortBy: [Consumption.TIME.descending()],
    );
  }
}
