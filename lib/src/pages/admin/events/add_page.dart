import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';

import 'package:tab_manager/models/ModelProvider.dart';
import 'package:tab_manager/repositories/event_repository.dart';

class EventAddPage extends StatefulWidget {
  const EventAddPage({Key? key}) : super(key: key);

  @override
  State<EventAddPage> createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  final _nameController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  Future<void> _save() async {
    String name = _nameController.text;
    TemporalDate startDate = TemporalDate.fromString(_startDateController.text);
    TemporalDate endDate = TemporalDate.fromString(_endDateController.text);

    Event event = Event(
      name: name,
      start_date: startDate,
      end_date: endDate,
    );

    await EventRepository.addEvent(event);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
      body: addWidget(),
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
                  decoration:
                      const InputDecoration(filled: true, labelText: 'Name')),
              TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(
                      filled: true, labelText: 'Start Date')),
              TextFormField(
                  controller: _endDateController,
                  decoration: const InputDecoration(
                      filled: true, labelText: 'End Date')),
              ElevatedButton(onPressed: _save, child: const Text('Save'))
            ],
          ),
        ),
      );
}
