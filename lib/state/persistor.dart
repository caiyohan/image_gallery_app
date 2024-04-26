import 'dart:convert';
import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'app_state.dart';

class AppPersistor extends Persistor<AppState> {
  @override
  Future<AppState> readState() async {
    final file = await _getFile();
    if (file.existsSync()) {
      final data = await file.readAsString();
      return compute(stateDecode, data);
    }
    return AppState();
  }

  @override
  Future<void> deleteState() async {
    /// TODO: Put here the code to delete the state from disk.
  }

  @override
  Future<void> persistDifference({
    required AppState? lastPersistedState,
    required AppState newState,
  }) async {
    /// TODO: Put here the code to save the state to disk.
  }

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/state.json');
  }

  String stateEncode(AppState st) {
    final json = st.toJson();
    return jsonEncode(json);
  }

  AppState stateDecode(String data) {
    final json = jsonDecode(data) as Map<String, dynamic>;
    return AppState.fromJson(json);
  }
}
