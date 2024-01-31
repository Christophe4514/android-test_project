import 'dart:convert';

import 'package:boutique_zando/models/operations_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OperationController with ChangeNotifier {
  List<OperationsModel> listOperations = [
    //OperationsModel(dateOperation: "20/10/2022", isAchat: true, nomArticle: "velo", pOperation: 250, qteOperation: 2),
  ];
  List<OperationsModel> listAchats = [];
  List<OperationsModel> listVentes = [];
  var caisse = 10000000.0;
  var progressionAchats = 0.0;
  var progressionVentes = 0.0;
  var achat = 0.0;
  var vente = 0.0;
  var benef = 0.0;

  void ajouterOperation(OperationsModel data) {
    data.idOperation = listOperations.length + 1;
    listOperations.insert(0, data);
    notifyListeners();
    somBenef();
    progression();
  }

  sommeDepenses() {
    var somDepense = 0.0;
    var resultat = listOperations.where((e) => e.isAchat == true).toList();
    for (var operation in resultat) {
      somDepense += operation.pOperation;
    }
    caisse -= somDepense;
    achat = somDepense;
    notifyListeners();
  }

  ajoutListAchat() {
    var resultat = listOperations.where((e) => e.isAchat == true).toList();
    listAchats = resultat;
  }

  ajoutListVente() {
    var resultat = listOperations.where((e) => e.isAchat == false).toList();
    listVentes = resultat;
  }

  transactions() {
    ajoutListAchat();
    ajoutListVente();
  }

  sommeRevenus() {
    var somRevenus = 0.0;
    var resultat = listOperations.where((e) => e.isAchat == false).toList();
    for (var operation in resultat) {
      somRevenus += operation.pOperation;
    }
    caisse += somRevenus;
    vente = somRevenus;
    notifyListeners();
  }

  somBenef() {
    sommeRevenus();
    sommeDepenses();
    benef = vente - achat;
  }

  progressionAchat() {
    var resultat = listOperations.where((e) => e.isAchat == true).toList();

    double prixTotal_n_1 = 0;
    if (resultat.length > 1) {
      prixTotal_n_1 = resultat[1].pOperation;
    }
    // dernière activité

    double prixTotal_n = 0;
    if (resultat.length > 1) {
      prixTotal_n = resultat[0].pOperation;
    }

    double progression = prixTotal_n_1 == 0
        ? 100.0
        : ((prixTotal_n - prixTotal_n_1) / prixTotal_n_1) * 100;
    print("progression achat : $progression");
    progressionAchats = progression;
    notifyListeners();
  }

  progressionVente() {
    var resultat = listOperations.where((e) => e.isAchat == false).toList();

    double prixTotal_n_1 = 0;
    if (resultat.length > 1) {
      prixTotal_n_1 = resultat[1].pOperation;
    }
    // dernière activité
    double prixTotal_n = 0;
    if (resultat.length > 1) {
      prixTotal_n = resultat[0].pOperation;
    }

    double progression = prixTotal_n_1 == 0
        ? 100.0
        : ((prixTotal_n - prixTotal_n_1) / prixTotal_n_1) * 100;
    progressionVentes = progression;
    notifyListeners();
  }

  progression() {
    progressionAchat();
    progressionVente();
  }

  recupererArticlesApi() async {
    var url = Uri(
        scheme: "http", host: "10.20.20.245", path: "api/articles", port: 8000);
    var reponse = await http.get(url);

    if (reponse.statusCode == 200) {
      String donneesBrutes = reponse.body;
      print(donneesBrutes);

      var tempList = json.decode(donneesBrutes) as List<dynamic>;
      List<OperationsModel> tempList2 =
          tempList.map((e) => OperationsModel.fromJson(e)).toList();
      listOperations.addAll(tempList2);

      print(reponse.body);
    }
  }

  creerArticlesApi(Map data) async {
    var url = Uri(
        scheme: "http", host: "10.20.20.245", path: "api/articles", port: 8000);
    print(url);
    print('body: ${json.encode(data)}');
    var reponse = await http.post(url, body: json.encode(data), headers: {
      'Content-type': 'application/json; charset=UTF-8',
    });
    print('Status ${reponse.statusCode}');
    print("envoi : ${reponse.body}");
  }
}
