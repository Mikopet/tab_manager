import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/event_repository.dart';
import 'package:tab_manager/src/pages/admin/events/add_page.dart';

class EventIndexPage extends StatefulWidget {
  const EventIndexPage({Key? key}) : super(key: key);

  @override
  State<EventIndexPage> createState() => _EventIndexPageState();
}

class _EventIndexPageState extends State<EventIndexPage> {
  List<Event> _events = [];
  bool isSynced = false;
  Stream<QuerySnapshot<Event>> stream = EventRepository.getEventsStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: indexWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => const EventAddPage()));
        },
        tooltip: 'add Event',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget indexWidget() {
    stream.listen((QuerySnapshot<Event> snapshot) {
      setState(() {
        _events = snapshot.items;
        isSynced = snapshot.isSynced;
      });
    });

    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        Event event = _events[index];
        return ListTile(
          title: Text(event.name),
          subtitle: Text('${event.start_date} - ${event.end_date}'),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Center(child: Icon(Icons.event)),
            ],
          ),
        );
      },
    );
  }
}
