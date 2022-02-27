import 'package:flutter/material.dart';

import '../../models/ModelProvider.dart';
import '../../repositories/event_repository.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: eventsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            EventRepository.addEvent();
          });
        },
        tooltip: 'add Event',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget eventsWidget() {
    return FutureBuilder<List<Event>>(
      future: EventRepository.getEvents(),
      builder: (context, AsyncSnapshot<List<Event>> snapshot) {
        if (!snapshot.hasData ||
            snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(child: CircularProgressIndicator())),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Event event = snapshot.data![index];
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
      },
    );
  }
}
