import 'package:dashboard/alert_dialog.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool quit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmationDialog();
          },
        );

        return quit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mon application'),
        ),
        body: Center(
          child: Text('Bienvenue dans mon application !'),
        ),
      ),
    );
  }
}
