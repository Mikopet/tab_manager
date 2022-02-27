import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/Event.dart';

class EventRepository {
  static addEvent() async {
    final now = TemporalTime.now()
        .format()
        .replaceAll(RegExp(r'[^0-9]'), '')
        .substring(0, 6);

    try {
      Event event = Event(
        name: 'Event #$now',
        start_date: TemporalDate.fromString("2022-02-22"),
        end_date: TemporalDate.fromString("2022-03-03"),
      );
      await Amplify.DataStore.save(event);
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Event>> getEvents() async {
    List<Event> events = await Amplify.DataStore.query(
      Event.classType,
    );

    return events;
  }
}
