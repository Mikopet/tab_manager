import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/events_page.dart';
import 'package:tab_manager/src/pages/products_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _navigateTo(c, page) {
    Navigator.of(c).push(MaterialPageRoute(builder: (c) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => _navigateTo(context, const ProductsPage()),
              child: const Text('Products'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => _navigateTo(context, const EventsPage()),
              child: const Text('Events'),
            ),
          ),
        ],
      ),
    );
  }
}
