import 'package:flutter/material.dart';
import 'package:i_can_do_it/controllers/challenges_controller.dart';

import '../../models/challenge_model.dart';
import '../../controllers/challenges_controller.dart';

class ChallengesListBuilder extends StatefulWidget {
  final Future<List<ChallengeModel>> challengeData;
  final ChallengesController controller;

  ChallengesListBuilder({
    @required this.challengeData,
    @required this.controller,
  });
  @override
  _ChallengesListBuilderState createState() => _ChallengesListBuilderState();
}

class _ChallengesListBuilderState extends State<ChallengesListBuilder> {
  String unityPattern = "unity_challenge.";

  @override
  Widget build(BuildContext context) {
    Future<List<ChallengeModel>> _challengesList = widget.challengeData;
    return FutureBuilder(
        future: _challengesList,
        builder: (context, AsyncSnapshot<List<ChallengeModel>> data) {
          List<ChallengeModel> _challengesList = data.data;

          if (!data.hasData) {
            return Text("pas de challenges de créés");
          }
          return ListView.builder(
            itemCount: _challengesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 3.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Dismissible(
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      final bool resultat = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Confimation",
                                  style: TextStyle(color: Colors.blue)),
                              content: Text(
                                  "Êtes-vous sûr de vouloir suprimer le challenge"),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Text("Oui"),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text("Non"),
                                )
                              ],
                            );
                          });
                      return resultat;
                    }
                    // on ajouter une confirmation pour l'autre sens.
                    return true;
                  },
                  background: Container(
                    // padding: EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: EdgeInsets.only(right: 10.0),
                    alignment: Alignment.centerRight,
                    color: Colors.green,
                    child: Icon(
                      Icons.check,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  key: Key(UniqueKey().toString()),
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(_challengesList[index].name),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Objectif :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(_challengesList[index].target.toString()),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(_challengesList[index]
                                .unity
                                .toString()
                                .replaceAll(unityPattern, "")
                                .toUpperCase()),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
