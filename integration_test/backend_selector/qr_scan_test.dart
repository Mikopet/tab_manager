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

  testWidgets('Scan QR code smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();
    await tester.pumpAndSettle();

    // Verify that we see the backend provider screen
    expect(find.byKey(backendPage), findsOneWidget);
    expect(find.byKey(homePage), findsNothing);
    expect(find.byKey(authenticator), findsNothing);
    expect(find.byKey(qrScanPage), findsNothing);

    // Go to scan
    await tester.tap(find.byIcon(Icons.qr_code_rounded));
    await tester.pumpAndSettle();

    // Verify we see the QR scan
    expect(find.byKey(authenticator), findsNothing);
    expect(find.byKey(backendPage), findsNothing);
    expect(find.byKey(homePage), findsNothing);
    expect(find.byKey(qrScanPage), findsOneWidget);
  });
}
