import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AmplifyConfigurationStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/backend_config.txt');
  }

  Future<String> readConfig() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeConfig(String config) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(config);
  }
}
