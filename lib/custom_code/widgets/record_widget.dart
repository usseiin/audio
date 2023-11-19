// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:permission_handler/permission_handler.dart';

import "dart:io";
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:record/record.dart';
import "package:path_provider/path_provider.dart";
import 'package:flutter/foundation.dart';

class RecordWidget extends StatefulWidget {
  const RecordWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _RecordWidgetState createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget> {
  bool _isRecording = false;
  String? path = '';
  final _audioRecorder = AudioRecorder();
  Directory? appDocumentsDir;

  @override
  void initState() {
    super.initState();
    setPath();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void setPath() async {
    appDocumentsDir = await getApplicationDocumentsDirectory();
  }

  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final path =
        "${appDocumentsDir!.path}/audio/${DateTime.now().millisecondsSinceEpoch}.m4a";
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(const RecordConfig(), path: path);
        bool isRecording = await _audioRecorder.isRecording();
        print("start recording");
        setState(() {
          _isRecording = isRecording;
        });
      } else {
        await Permission.microphone.request();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    // This is the path of the recorded file.
    path = await _audioRecorder.stop();
    print("recording stop");
    setState(() {
      _isRecording = false;
    });
  }

  Widget _buildRecorder() {
    if (_isRecording) {
      return InkWell(
        onTap: () async {
          _stop();
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryBackground,
              width: 4,
            ),
          ),
          child: Icon(
            Icons.mic_off,
            color: FlutterFlowTheme.of(context).primaryBackground,
            size: 30,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () async {
          _start();
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryBackground,
              width: 4,
            ),
          ),
          child: Icon(
            Icons.mic_sharp,
            color: FlutterFlowTheme.of(context).primaryBackground,
            size: 30,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildRecorder()],
      ),
    );
  }
}
