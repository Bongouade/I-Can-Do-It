import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String unityChallenge = "KG";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("ICanDoIt"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xff414a4c),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[700],
        onPressed: () {
          buildBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PersistentBottomSheetController buildBottomSheet() {
    return scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                TextFormField(
                  validator: (value) {
                    final RegExp checkReg = RegExp(r'^\D+$');
                    if (value.isEmpty) {
                      return "Merci d'entrer un nom pour le challenge";
                    } else if (!checkReg.hasMatch(value)) {
                      return "$value";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Nom du Challenge",
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    final _isInt = int.tryParse(value);
                    if (_isInt == null) {
                      return "Merci d'entrer uniquement des chiffres pour l'ojectif";
                    }

                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Objectif",
                  ),
                ),
                DropdownButtonFormField(
                  value: unityChallenge,
                  onChanged: (value) {
                    setState(() {
                      unityChallenge = value;
                      //  print(value);
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      unityChallenge = value;
                      // print("2");
                    });
                  },
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      value: "KG",
                      child: Text("Kg"),
                    ),
                    DropdownMenuItem(
                      value: "Km",
                      child: Text("Km"),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      // formKey.currentState.save();
                    }
                  },
                  child: Text("Ajouter le Chanllenge"),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
