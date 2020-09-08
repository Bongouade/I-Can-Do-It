import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("ICanDoIt"),
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
        child: Text(""),
      );
    });
  }
}
