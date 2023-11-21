import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'reco_model.dart';
export 'reco_model.dart';

class RecoWidget extends StatefulWidget {
  const RecoWidget({
    super.key,
    required this.audioPaths,
  });

  final List<String>? audioPaths;

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

    context.watch<FFAppState>();

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
          child: Visibility(
            visible: widget.audioPaths!.isNotEmpty,
            child: Builder(
              builder: (context) {
                final audioPaths = widget.audioPaths!.toList();
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(audioPaths.length, (audioPathsIndex) {
                    final audioPathsItem = audioPaths[audioPathsIndex];
                    return Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: Text(
                        functions
                            .nameFromPath(widget.audioPaths![audioPathsIndex]),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
