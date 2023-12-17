// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
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
  late AudioRecorder _audioRecorder;
  Directory? appDocumentsDir;

  @override
  void initState() {
    super.initState();
    setPath();
    _audioRecorder = AudioRecorder();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void setPath() async {
    appDocumentsDir = await getApplicationSupportDirectory();
  }

  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final pathDir = Directory("${appDocumentsDir!.path}/audio");
    if (!(await pathDir.exists())) {
      await pathDir.create(recursive: true);
    }
    final path =
        await "${pathDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.mp3";
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(const RecordConfig(), path: path);
        bool isRecording = await _audioRecorder.isRecording();
        if (!isRecording) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "error recording",
              ),
              duration: Duration(milliseconds: 3000),
              backgroundColor: Colors.black,
            ),
          );
          return;
        }
        setState(() {
          _isRecording = isRecording;
        });
      } else {
        await Permission.microphone.request();
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
  }

  Future<void> _stop() async {
    // This is the path of the recorded file.
    path = await _audioRecorder.stop();
    final audio = await File(path!).create(recursive: true);
    await transcribeAudio(path!);
    FFAppState().update(() {
      FFAppState().currentPath = path!;
    });
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFFF0000),
                  width: 6,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: ClipOval(
                  child: GestureDetector(
                    onLongPress: () async {
                      _start();
                    },
                    onLongPressUp: () async {
                      _stop();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _isRecording
                            ? Color(0xFFFF75533)
                            : Color(0xFFFF0000),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRecorder(),
            ],
          ),
        ],
      ),
    );
  }
}
