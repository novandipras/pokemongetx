import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokemongetx/src/utils/constants/constants.dart';

import '../../../domain/models/model.dart';

class LocalStorageService extends GetxService {
  SharedPreferences? _sharedPreferences;

  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  List<String>? get savedMonster {
    final rawJson =
        _sharedPreferences?.getStringList(KeySP.savedMonster.toString());
    return rawJson;
  }

  set savedMonster(List<String>? newData) {
    if (newData != null) {
      var currentList = _sharedPreferences?.getStringList(
            KeySP.savedMonster.toString(),
          ) ??
          [];
      currentList.addAll(newData);
      _sharedPreferences?.setStringList(
        KeySP.savedMonster.toString(),
        currentList,
      );
    }
  }

  set releaseMonsterToNature(List<String>? newData) {
    if (newData != null) {
      var currentList = _sharedPreferences?.getStringList(
        KeySP.savedMonster.toString(),
      ) ??
          [];
      currentList.removeWhere((e) => Result.fromJson(jsonDecode(e)).name == Result.fromJson(jsonDecode(newData.first)).name);
      _sharedPreferences?.setStringList(
        KeySP.savedMonster.toString(),
        currentList,
      );
    }
  }
}
