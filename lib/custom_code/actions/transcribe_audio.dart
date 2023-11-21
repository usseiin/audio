// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import "package:http/http.dart" as http;
import 'dart:io';
import "dart:convert";

Future<String> transcribeAudio(String path) async {
  final String apiUrl = 'https://api.recc.ooo/transcript-audio-file';

  final String audioFilePath = path;

  List<int> audioBytes = await File(audioFilePath).readAsBytes();

  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  request.files.add(
      http.MultipartFile.fromBytes('file', audioBytes, filename: 'audio.m4a'));

  try {
    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData.toString();
    } else {
      return "error transcribing audio file";
    }
  } catch (error) {
    return "error: $error";
  }
}
