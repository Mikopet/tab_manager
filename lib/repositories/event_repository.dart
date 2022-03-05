import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:tab_manager/models/Event.dart';

class EventRepository {
  // TODO: create valid logic
  static addEvent() async {
    final now = TemporalTime.now()
        .format()
        .replaceAll(RegExp(r'[^0-9]'), '')
        .substring(0, 6);

    try {
      Event event = Event(
        name: 'Event #$now',
        start_date: TemporalDate.fromString("2022-02-22"),
        end_date: TemporalDate.fromString("2022-03-22"),
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

  static Future<List<Event>> getOngoingEvents() async {
    List<Event> events = await Amplify.DataStore.query(
      Event.classType,
      where: Event.START_DATE.le(TemporalDate.now()).and(
            Event.END_DATE.ge(TemporalDate.now()),
          ),
      sortBy: [Event.END_DATE.descending()],
    );

    return events;
  }
}
