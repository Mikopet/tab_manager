import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:tab_manager/src/app.dart';
import 'package:tab_manager/src/backend.dart';

void main() {
  runApp(
    Phoenix(
      child: const BackendProvider(
        child: TabManager(authenticator: false),
      ),
    ),
  );
}
