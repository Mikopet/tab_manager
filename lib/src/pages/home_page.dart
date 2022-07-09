import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/consumption_repository.dart';
import 'package:tab_manager/repositories/event_repository.dart';
import 'package:tab_manager/src/components/drawer.dart';
import 'package:tab_manager/src/pages/add_consumption_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
    required this.admin,
    required this.userId,
  }) : super(key: key);

  final String title;
  final String userId;
  final bool admin;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Consumption? _lastConsumption;
  int _sumConsumption = -1;

  List<Event> _ongoingEvents = [];
  bool eventsSynced = false;
  Stream<QuerySnapshot<Event>> ongoingEventStream =
      EventRepository.getOngoingEventsStream();

  Stream<QuerySnapshot<Consumption>>? ownConsumptionStream;

  @override
  Widget build(BuildContext context) {
    ongoingEventStream.listen((QuerySnapshot<Event> snapshot) {
      setState(() {
        _ongoingEvents = snapshot.items;
        eventsSynced = snapshot.isSynced;
      });
    });

    // TODO: fix this pile of crap
    ownConsumptionStream ??=
        ConsumptionRepository.getOwnConsumptionsStream(widget.userId);
    ownConsumptionStream?.listen((QuerySnapshot<Consumption> snapshot) {
      setState(() {
        try {
          _sumConsumption = snapshot.items
              .fold(0, (int p, Consumption c) => p + c.product.unit_price);
        } on AmplifyCodeGenModelException catch (_) {
          setState(() {
            ownConsumptionStream =
                ConsumptionRepository.getOwnConsumptionsStream(widget.userId);
          });
        }
      });
    });

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        endDrawer: NavDrawer(admin: widget.admin, userId: widget.userId),
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
                  _sumConsumption.toString(),
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
            ? FloatingActionButton(
                onPressed: () {
                  _storeConsumption(context); // TODO: handle multiple events
                },
                tooltip: 'Add consumption',
                child: const Icon(Icons.add),
              )
            : const FloatingActionButton(
                onPressed: null,
                tooltip: 'You have no ongoing events',
                backgroundColor: Colors.grey,
                child: Icon(Icons.add),
              ));
  }

  void _storeConsumption(BuildContext context) async {
    // TODO: handle return without pressing on product
    final Product? product = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddConsumptionPage(
          event: _ongoingEvents.first,
          undo: _undoConsumption,
        ),
      ),
    );

    if (product != null) {
      _lastConsumption = Consumption(
        owner: widget.userId,
        product: product,
        amount: 1,
        time: TemporalDateTime.now(),
      );

      setState(() {
        ConsumptionRepository.addConsumption(_lastConsumption!);
      });
    }
  }

  void _undoConsumption() async {
    Amplify.DataStore.delete(_lastConsumption!);
  }
}
