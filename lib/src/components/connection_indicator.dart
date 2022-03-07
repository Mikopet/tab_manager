import 'package:flutter/material.dart';

import 'package:tab_manager/src/app.dart';

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
      children: const [
        // TODO: make it work
        Text('ALPHA', style: TextStyle(color: Colors.red)),
        /*
        Text(
          AppState.networkStatus ? 'Online' : 'Offline',
          style: AppState.networkStatus ? onStyle : offStyle,
        ),
        Text(
          AppState.outboxStatus ? 'Synced' : 'Unynced',
          style: AppState.outboxStatus ? onStyle : offStyle,
        ),
         */
      ],
    );
  }
}
