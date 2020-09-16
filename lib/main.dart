import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'controllers/challenges_controller.dart';

void main() => runApp(ICanDoIt());

class ICanDoIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "I Can Do It",
      home: ChangeNotifierProvider<ChallengesController>(
        create: (context) => ChallengesController(),
        // create: (BuildContext context) {  },
        child: Home(),
      ),
    );
  }
}
