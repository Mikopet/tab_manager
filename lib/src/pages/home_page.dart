import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/event_repository.dart';
import 'package:tab_manager/src/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> _ongoingEvents = [];
  bool isSynced = false;
  Stream<QuerySnapshot<Event>> stream =
      EventRepository.getOngoingEventsStream();

  @override
  Widget build(BuildContext context) {
    stream.listen((QuerySnapshot<Event> snapshot) {
      setState(() {
        _ongoingEvents = snapshot.items;
        isSynced = snapshot.isSynced;
      });
    });

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        endDrawer: const NavDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have open tabs of',
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'X',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(
                'value spent',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
        floatingActionButton: _ongoingEvents.isNotEmpty
            ? const FloatingActionButton(
                onPressed: null,
                tooltip: 'Add consumption',
                child: Icon(Icons.add),
              )
            : const FloatingActionButton(
                onPressed: null,
                tooltip: 'You have no ongoing events',
                backgroundColor: Colors.grey,
                child: Icon(Icons.add),
              ));
  }
}
