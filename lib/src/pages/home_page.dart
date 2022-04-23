import 'package:flutter/material.dart';

import 'package:tab_manager/repositories/event_repository.dart';
import 'package:tab_manager/src/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
  @override
  final Key key = const Key('HomePage');
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      endDrawer: const NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO: if there is no backend at all, there should be a button to navigate to manual page
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
          }),
    );
  }
}
