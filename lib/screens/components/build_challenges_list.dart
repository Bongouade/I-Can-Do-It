import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/challenge_model.dart';
import '../../controllers/challenges_controller.dart';

class ChallengesListBuilder extends StatelessWidget {
  final String unityPattern = "unity_challenge.";

  @override
  Widget build(BuildContext context) {
    List<ChallengeModel> _challengesList =
        Provider.of<ChallengesController>(context).getChallenge();
    final ChallengesController provider =
        Provider.of<ChallengesController>(context);

    if (_challengesList.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Text(
          "Aucun challenge en cours pourtant tu peux le faire !",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.orange[600],
            fontSize: 18.0,
          ),
        ),
      );
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
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                Scaffold.of(context).showSnackBar(
                  _buildSanackBar(
                    content:
                        "Le challenge ${_challengesList[index].name} a bien été validé",
                  ),
                );
                provider.remove(index: index);
              }
              if (direction == DismissDirection.startToEnd) {
                Scaffold.of(context).showSnackBar(
                  _buildSanackBar(
                    content:
                        "Le challenge ${_challengesList[index].name} à bien été suprimé",
                  ),
                );
                provider.remove(index: index);
              }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                final bool resultat = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Confimation",
                            style: TextStyle(
                              color: Colors.blue,
                            )),
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
  }

  SnackBar _buildSanackBar({@required String content}) {
    return SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }
}
