import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:tab_manager/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const backendPage = Key('BackendPage');
  const homePage = Key('HomePage');
  const authenticator = Key('Authenticator');
  const qrScanPage = Key('QRScanPage');

  testWidgets('Skip backend smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();
    await tester.pumpAndSettle();

    // Verify that we see the backend provider screen
    expect(find.byKey(backendPage), findsOneWidget);
    expect(find.byKey(homePage), findsNothing);
    expect(find.byKey(authenticator), findsNothing);
    expect(find.byKey(qrScanPage), findsNothing);

    // Skip the backend addition
    await tester.tap(find.byIcon(Icons.fast_forward_rounded));
    await tester.pumpAndSettle();

    // Verify we see the app not the auth
    expect(find.byKey(authenticator), findsNothing);
    expect(find.byKey(backendPage), findsNothing);
    expect(find.byKey(qrScanPage), findsNothing);
    expect(find.byKey(homePage), findsOneWidget);
  });
}
