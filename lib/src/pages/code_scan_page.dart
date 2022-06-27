import 'package:flutter/material.dart';

class CodeScanPage extends StatefulWidget {
  const CodeScanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CodeScanPageState();
}

class _CodeScanPageState extends State<CodeScanPage> {
  final _codeController = TextEditingController();

  Future<void> _save() async {
    Navigator.pop(context, _codeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Backend Code')),
      backgroundColor: Colors.white,
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
            controller: _codeController,
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Backend code',
              icon: Icon(Icons.batch_prediction),
            ),
          ),
          ElevatedButton(onPressed: _save, child: const Text('Save'))
        ],
      ),
    ),
  );
}
