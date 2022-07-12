import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:tab_manager/src/pages/home_page.dart';
import 'package:tab_manager/src/components/theme.dart';

class TabManager extends StatefulWidget {
  const TabManager({Key? key, required this.authenticator}) : super(key: key);

  final bool authenticator;

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<TabManager> {
  bool _admin = false;
  String _userId = '';

  @override
  void initState() {
    super.initState();

    if (widget.authenticator) {
      Amplify.Auth.getCurrentUser().then((AuthUser user) {
        Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(
            getAWSCredentials: true,
          ),
        ).then((AuthSession session) {
          CognitoAuthSession s = session as CognitoAuthSession;
          String? token = s.userPoolTokens?.accessToken;
          List groups = [];

          if (token != null) {
            Map<String, dynamic> payload = JwtDecoder.decode(token);
            if (payload.containsKey('cognito:groups')) {
              groups.addAll(payload['cognito:groups']);
            }
          }

          if (groups.contains("Admin")) {
            setState(() => _admin = true);
          }
          setState(() => _userId = user.userId);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authenticator) {
      return Authenticator(
        key: const Key('Authenticator'),
        child: MaterialApp(
          builder: Authenticator.builder(),
          title: 'TabManager',
          theme: appTheme,
          home: HomePage(
            key: const Key('HomePage'),
            title: 'TabManager',
            admin: _admin,
            userId: _userId,
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'TabManager',
      theme: appTheme,
      home: const HomePage(
        key: Key('HomePage'),
        title: 'TabManager Debug',
        admin: true,
        userId: 'debugAdmin',
      ),
    );
  }
}
