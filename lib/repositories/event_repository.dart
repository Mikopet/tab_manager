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

  static Stream<QuerySnapshot<Event>> getEventsStream() {
    return Amplify.DataStore.observeQuery(
      Event.classType,
      sortBy: [Event.END_DATE.descending()],
    );
  }

  static Stream<QuerySnapshot<Event>> getNonPastEventsStream() {
    return Amplify.DataStore.observeQuery(
      Event.classType,
      where: Event.END_DATE.ge(TemporalDate.now()),
      sortBy: [Event.START_DATE.ascending()],
    );
  }

  static Stream<QuerySnapshot<Event>> getOngoingEventsStream() {
    return Amplify.DataStore.observeQuery(
      Event.classType,
      where: Event.START_DATE.le(TemporalDate.now()).and(
            Event.END_DATE.ge(TemporalDate.now()),
          ),
      sortBy: [Event.START_DATE.ascending()],
    );
  }
}
