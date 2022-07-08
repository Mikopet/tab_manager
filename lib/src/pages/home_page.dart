import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/consumption_repository.dart';
import 'package:tab_manager/repositories/event_repository.dart';
import 'package:tab_manager/src/components/drawer.dart';
import 'package:tab_manager/src/pages/add_consumption_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAdmin = false;
  String _userId = '';
  late Consumption _lastConsumption;

  @override
  void initState() {
    super.initState();

    // TODO: refact this to the app.dart
    if (widget.title.contains("Debug")) {
      _isAdmin = true;
      _userId = 'debugAdmin';
    } else {
      Amplify.Auth.getCurrentUser().then((AuthUser user) {
        Amplify.Auth.fetchAuthSession(
                options: CognitoSessionOptions(getAWSCredentials: true))
            .then((AuthSession session) {
          CognitoAuthSession s = session as CognitoAuthSession;
          String? token = s.userPoolTokens?.accessToken;
          List groups = [];

          if (token != null) {
            Map<String, dynamic> payload = JwtDecoder.decode(token);
            groups.addAll(payload['cognito:groups']);
          }

          if (groups.contains("Admin")) {
            setState(() {
              _isAdmin = true;
            });
          }
        });
        _userId = user.userId;
        setState(() {
          ownConsumptionStream =
              ConsumptionRepository.getOwnConsumptionsStream(_userId);
        });
      });
    }
  }

  List<Event> _ongoingEvents = [];
  bool eventsSynced = false;
  Stream<QuerySnapshot<Event>> ongoingEventStream =
      EventRepository.getOngoingEventsStream();

  List<Consumption> _consumptions = [];
  bool consumptionsSynced = false;
  late Stream<QuerySnapshot<Consumption>> ownConsumptionStream;

  @override
  Widget build(BuildContext context) {
    ongoingEventStream.listen((QuerySnapshot<Event> snapshot) {
      setState(() {
        _ongoingEvents = snapshot.items;
        eventsSynced = snapshot.isSynced;
      });
    });

    ownConsumptionStream.listen((QuerySnapshot<Consumption> snapshot) {
      setState(() {
        _consumptions = snapshot.items;
        consumptionsSynced = snapshot.isSynced;
      });
    });

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        endDrawer: NavDrawer(admin: _isAdmin, userId: _userId),
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
                  _consumptions
                      .fold(
                        0,
                        (int p, Consumption c) => p + c.product.unit_price,
                      )
                      .toString(),
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
    final Product product = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddConsumptionPage(
          event: _ongoingEvents.first,
          undo: _undoConsumption,
        ),
      ),
    );

    _lastConsumption = Consumption(
      owner: _userId,
      product: product,
      amount: 1,
      time: TemporalDateTime.now(),
    );

    ConsumptionRepository.addConsumption(_lastConsumption);
  }

  void _undoConsumption() async {
    Amplify.DataStore.delete(_lastConsumption);
  }
}
