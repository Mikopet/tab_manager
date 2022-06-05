import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/event_repository.dart';
import 'package:tab_manager/repositories/product_repository.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({Key? key}) : super(key: key);

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final _nameController = TextEditingController();
  final _unitPriceController = TextEditingController();

  late Event _selectedEvent;
  List<Event> _events = [];
  bool isSynced = false;
  Stream<QuerySnapshot<Event>> stream =
      EventRepository.getNonPastEventsStream();

  Future<void> _save() async {
    String name = _nameController.text;
    int unitPrice = int.parse(_unitPriceController.text);

    Product product = Product(
      name: name,
      unit_price: unitPrice,
      event: _selectedEvent,
    );

    await ProductRepository.addProduct(product);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: addWidget(),
    );
  }

  Widget dropdown(BuildContext context) {
    stream.listen((QuerySnapshot<Event> snapshot) {
      setState(() {
        _events = snapshot.items;
        isSynced = snapshot.isSynced;
      });
    });

    return DropdownButtonFormField<Event>(
      // value: _events.first,
      hint: const Text('Event'),
      isExpanded: true,
      isDense: true,
      decoration: const InputDecoration(
        filled: true,
        labelText: 'Event',
        icon: Icon(Icons.event_available),
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 40),
      ),
      onChanged: (Event? value) {
        setState(() {
          _selectedEvent = value!;
        });
      },
      items: _events.map((Event e) {
        return DropdownMenuItem(
          value: e,
          child: ListTile(
            title: Text(e.name),
            subtitle: Text("${e.start_date}-${e.end_date}"),
          ),
        );
      }).toList(),
    );
  }

  Widget addWidget() => Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Name',
                  icon: Icon(Icons.edit_note),
                ),
              ),
              TextFormField(
                controller: _unitPriceController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Unit Price',
                  icon: Icon(Icons.price_change),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              dropdown(context),
              ElevatedButton(onPressed: _save, child: const Text('Save'))
            ],
          ),
        ),
      );
}
