import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/events_page.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Offline',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Synced',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ]),
            decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.webp'))),
          ),
          ListTile(
            leading: const Icon(Icons.event_rounded),
            title: const Text('Events'),
            onTap: () => _navigateTo(context, const EventsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.input_rounded),
            title: const Text('Consumption'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text('Manual'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
