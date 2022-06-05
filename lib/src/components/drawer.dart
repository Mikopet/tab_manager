import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/src/components/connection_indicator.dart';
import 'package:tab_manager/src/pages/admin/admin_page.dart';
import 'package:tab_manager/src/pages/consumption_page.dart';
import 'package:tab_manager/src/pages/settings_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  void _navigateTo(c, page) {
    Navigator.of(c).push(MaterialPageRoute(builder: (c) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // TODO: write connection test logic
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [ConnectionIndicator()],
            ),
            decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.webp'))),
          ),
          ListTile(
            leading: const Icon(Icons.edit_note_rounded),
            title: const Text('Admin'),
            onTap: () => _navigateTo(context, const AdminPage()),
          ),
          ListTile(
            leading: const Icon(Icons.input_rounded),
            title: const Text('Consumption'),
            onTap: () => _navigateTo(context, const ConsumptionPage()),
          ),
          // ListTile(
          //   leading: const Icon(Icons.book_rounded),
          //   title: const Text('Manual'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Settings'),
            onTap: () => _navigateTo(context, const SettingsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Logout'),
            onTap: () => Amplify.Auth.signOut(),
          ),
        ],
      ),
    );
  }
}
