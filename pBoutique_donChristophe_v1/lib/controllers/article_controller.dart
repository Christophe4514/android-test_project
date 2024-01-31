import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/article_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ArticleController with ChangeNotifier {
  GetStorage stockage = GetStorage();
  List<ArticleModel> listArticles = [
    ArticleModel(nom: "velo", quantite_initial: 20, pu: 200),
    ArticleModel(nom: "voiture", quantite_initial: 20, pu: 200),
  ]; // liste initiale
  List<String> tableNomsArticles = [];

  ArticleController() {
    recupererDansStockageLocale();
  }

  recupererDansStockageLocale() {
    //lecture base de données
    stockage.read("LISTE_ARTICLES");
    notifyListeners();
  }

  // focntion pour ajouter un article
  void ajouterArticle(ArticleModel data) {
    data.id = listArticles.length + 1;
    listArticles.add(data);

    stockage.write("LISTE_ARTICLES", listArticles);
    notifyListeners();
    tableauArticles();

    creerArticlesApi(data.toJson());
  }

  void modifierArticle(ArticleModel data) {
    var resultat = listArticles.where((e) => e.id == data.id).toList();
    if (resultat.isNotEmpty) {
      resultat[0].nom = data.nom;
      resultat[0].pu = data.pu;
      resultat[0].quantite_initial = data.quantite_initial;
      notifyListeners();
    }
  }

  void supprimerArticle(ArticleModel data) {
    print(listArticles.length);
    var resultat = listArticles.indexWhere((e) => e.id == data.id);
    if (resultat != -1) {
      print(resultat);
      listArticles.removeAt(resultat);
      //resultat.remove(resultat[0]);
      notifyListeners();
    }
  }

  tableauArticles() {
    for (var article in listArticles) {
      tableNomsArticles.add(article.nom);
    }
  }

  recupererArticlesApi() async {
    var url = Uri(
        scheme: "http", host: "10.20.20.245", path: "api/articles", port: 8000);
    var reponse = await http.get(url);

    if (reponse.statusCode == 200) {
      String donneesBrutes = reponse.body;
      print(donneesBrutes);

      var tempList = json.decode(donneesBrutes) as List<dynamic>;
      List<ArticleModel> tempList2 = tempList.map((e) => ArticleModel.fromJson(e)).toList();
      listArticles.addAll(tempList2);

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
