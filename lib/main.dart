import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:tab_manager/src/app.dart';

void main() {
  runApp(
    Phoenix(
      child: const TabManager(),
    ),
  );
}
