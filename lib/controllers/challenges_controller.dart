import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/challenge_model.dart';

const String KeyAcess = "ChallengesList";

class ChallengesController extends ChangeNotifier {
  List<ChallengeModel> _challengesList = [];
  SharedPreferences _localData;

  ChallengesController() {
    _initChallengesList();
  }

  List<ChallengeModel> getChallenge() {
    return UnmodifiableListView(_challengesList);
  }

  void _initChallengesList() async {
    _localData = await SharedPreferences.getInstance();
    // _localData.clear();
    final List<String> _tempList = _localData.getStringList(KeyAcess);

    if (_tempList != null) {
      // final List<dynamic> _jsonDecodeList = _tempList
      // ou celui du bas, il y a une erreur qui va arrêter l'application
      // alors tu remets l'ecriture du haut ou tu cast le tout
      // puisqu'on connait la sortie
      final List<Map<String, dynamic>> _jsonDecodeList = _tempList
          .map((challengeEncoded) => jsonDecode(challengeEncoded))
          .toList()
          .cast<Map<String, dynamic>>();

      _challengesList = _jsonDecodeList
          .map((challenge) => ChallengeModel.fromJSON(challenge))
          .toList();

      print(_challengesList);
    }
    notifyListeners();
  }

  void addChallenge(
      {@required String name,
      @required String target,
      @required String unity}) async {
    _challengesList.add(
      ChallengeModel(
        name: name,
        target: int.parse(target),
        unity: unity == "KG" ? unity_challenge.kg : unity_challenge.km,
      ),
    );
    //sauvegarde de nos données
    await _save();
    notifyListeners();
  }

  Future<bool> _save({bool remove}) async {
    if (_challengesList.length < 1 && remove ?? false) {
      return _localData.setStringList(KeyAcess, []);
    }
    if (_challengesList.isNotEmpty) {
      List<String> _jsonList = _challengesList
          .map((challenge) => jsonEncode(challenge.toJSON()))
          .toList();
      print(_jsonList);
      return _localData.setStringList(KeyAcess, _jsonList);
    }
    return false;
  }

  void remove({@required int index}) async {
    _challengesList.removeAt(index);
    await _save(remove: true);
    notifyListeners();
  }
}
