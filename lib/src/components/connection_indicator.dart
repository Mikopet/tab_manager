import 'package:flutter/material.dart';

import 'package:tab_manager/src/app.dart';
import 'package:tab_manager/src/backend.dart';

class ConnectionIndicator extends StatefulWidget {
  const ConnectionIndicator({Key? key}) : super(key: key);

  @override
  State<ConnectionIndicator> createState() => _ConnectionIndicatorState();
}

class _ConnectionIndicatorState extends State<ConnectionIndicator> {
  @override
  Widget build(BuildContext context) {
    const offStyle = TextStyle(color: Colors.yellow);
    const onStyle = TextStyle(color: Colors.green);

    return Column(
      children: [
        Text(
          BackendState.networkStatus ? 'Online' : 'Offline',
          style: BackendState.networkStatus ? onStyle : offStyle,
        ),
        Text(
          BackendState.outboxStatus ? 'Synced' : 'Unsynced',
          style: BackendState.outboxStatus ? onStyle : offStyle,
        ),
      ],
    );
  }
}
