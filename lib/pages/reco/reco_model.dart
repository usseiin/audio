import '/flutter_flow/flutter_flow_util.dart';
import 'reco_widget.dart' show RecoWidget;
import 'package:flutter/material.dart';

class RecoModel extends FlutterFlowModel<RecoWidget> {
  ///  Local state fields for this page.

  List<String> audioPath = [];
  void addToAudioPath(String item) => audioPath.add(item);
  void removeFromAudioPath(String item) => audioPath.remove(item);
  void removeAtIndexFromAudioPath(int index) => audioPath.removeAt(index);
  void insertAtIndexInAudioPath(int index, String item) =>
      audioPath.insert(index, item);
  void updateAudioPathAtIndex(int index, Function(String) updateFn) =>
      audioPath[index] = updateFn(audioPath[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getAudioPath] action in reco widget.
  List<String>? audios;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
