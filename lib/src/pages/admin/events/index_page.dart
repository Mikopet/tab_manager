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
