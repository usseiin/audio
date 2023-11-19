// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
Future<List<String>> getAudioPath() async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  List<String> files = [];
  try {
    // Get the application documents directory
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    // Specify the folder path you want to display files from
    String folderPath = "${appDocumentsDirectory.path}/audio";

    // Get the list of files in the folder
    List<FileSystemEntity> folderFiles = Directory(folderPath).listSync();
    for (var file in folderFiles) {
      files.add(file.path);
    }
    return files;
  } catch (e) {
    print("Error getting files: $e");
    return files;
  }
}
