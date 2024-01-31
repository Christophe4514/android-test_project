import 'dart:async';

import 'package:dashboard/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Notificat extends StatefulWidget {
  const Notificat({Key? key});

  @override
  State<Notificat> createState() => _NotificatState();
}

class _NotificatState extends State<Notificat> {
  var temp = 21;
  late Timer _timer;
  int _counter = 0;

  Future<void> _refreshData() async {
    // Effectuez vos opérations de chargement ou de mise à jour des données ici
    temp = temp;
    // Exemple asynchrone simulé
    await Future.delayed(Duration(seconds: 2));
    if (temp < 30) {
      Noti.showBigTextNotificaation(
        id: 0,
        title: "Dépassement de Température",
        body:
            'La température de votre logette a dépassé le seuil normal. Veuillez vérifier le problème et, si cela persiste, éteignez votre logette.',
        fln: flutterLocalNotificationsPlugin,
      );
    }
    // Mettez à jour l'état de votre widget ici, si nécessaire
    setState(() {
      temp = temp;
      // Mettez à jour les données de votre widget
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _counter++;
        _refreshData();
      });
    });
    Noti.initialize(flutterLocalNotificationsPlugin);
    setState(() {
      temp = 29;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshData(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.deepOrangeAccent],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blue.withOpacity(0.5),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 200,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  _refreshData();
                },
                child: Text("Click"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
