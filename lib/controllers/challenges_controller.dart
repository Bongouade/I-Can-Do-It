import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../models/challenge_model.dart';

class ChallengesController {
  List<ChallengeModel> _challengesList = [];

  List<ChallengeModel> getChallenges() {
    return _challengesList;
  }

  
}
