import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:tab_manager/models/Event.dart';

class EventRepository {
  static addEvent(Event event) async {
    try {
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

  static Stream<QuerySnapshot<Event>> getEventsStream() {
    return Amplify.DataStore.observeQuery(
      Event.classType,
      sortBy: [Event.END_DATE.descending()],
    );
  }
}
