import 'package:flutter/material.dart';

import 'package:tab_manager/src/pages/admin/consumptions/index_page.dart';
import 'package:tab_manager/src/pages/admin/events/index_page.dart';
import 'package:tab_manager/src/pages/admin/products/index_page.dart';
import 'package:tab_manager/src/pages/admin/stocks/index_page.dart';

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
              onPressed: () => _navigateTo(context, const EventIndexPage()),
              child: const Text('Events'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => _navigateTo(context, const ProductIndexPage()),
              child: const Text('Products'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => _navigateTo(context, const StockIndexPage()),
              child: const Text('Stocks'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => _navigateTo(context, const ConsumptionIndexPage()),
              child: const Text('Consumptions'),
            ),
          ),
        ],
      ),
    );
  }
}
