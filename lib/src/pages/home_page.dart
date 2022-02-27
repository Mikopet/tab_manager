import 'package:flutter/material.dart';

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
        .push(MaterialPageRoute(
            builder: (context) => const EventsPage()))
        .then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have no ongoing events'),
            TextButton(
              onPressed: _gotoEventsPage,
              child: const Text('See all Events'),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Nothing yet',
        child: Icon(Icons.add),
      ),
    );
  }
}
