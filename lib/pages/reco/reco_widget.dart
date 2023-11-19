import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'reco_model.dart';
export 'reco_model.dart';

class RecoWidget extends StatefulWidget {
  const RecoWidget({super.key});

  @override
  _RecoWidgetState createState() => _RecoWidgetState();
}

class _RecoWidgetState extends State<RecoWidget> {
  late RecoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.audios = await actions.getAudioPath();
      setState(() {
        _model.audioPath = _model.audios!.toList().cast<String>();
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Page Title',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              final audioPaths = _model.audioPath.toList();
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(audioPaths.length, (audioPathsIndex) {
                  final audioPathsItem = audioPaths[audioPathsIndex];
                  return Text(
                    audioPathsIndex.toString(),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}