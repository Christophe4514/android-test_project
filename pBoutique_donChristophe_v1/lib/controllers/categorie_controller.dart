import 'package:boutique_zando/models/article_model.dart';
import 'package:boutique_zando/models/categorie_model.dart';
import 'package:flutter/material.dart';

class CategorieController with ChangeNotifier {
  List<CategorieModel> listCategories = [];

  void ajouterCategorie(CategorieModel data) {
    data.id = listCategories.length + 1;
    listCategories.add(data);
    notifyListeners();
  }

  void ajouterArticle(var id) {
    var categorie = CategorieController();
    ArticleModel art =
        ArticleModel(nom: "biscuit", quantite_initial: 200, pu: 1500);
  }
}
