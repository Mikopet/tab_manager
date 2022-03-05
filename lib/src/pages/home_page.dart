import 'package:flutter/material.dart';
import 'package:tab_manager/repositories/event_repository.dart';

import '../drawer.dart';
import 'events_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _gotoEventsPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const EventsPage()))
        .then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      endDrawer: const NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have X opened tabs in Y value spent'),
            TextButton(
              onPressed: _gotoEventsPage,
              child: const Text('See all Events'),
            ),
          ],
        ),
      ),
      floatingActionButton: FutureBuilder<List>(
          future: EventRepository.getOngoingEvents(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return const FloatingActionButton(
                onPressed: null,
                tooltip: 'Add consumption',
                child: Icon(Icons.add),
              );
            } else {
              return const FloatingActionButton(
                onPressed: null,
                tooltip: 'You have no ongoing events',
                backgroundColor: Colors.grey,
                child: Icon(Icons.add),
              );
            }
          }
      ),
    );
  }
}
