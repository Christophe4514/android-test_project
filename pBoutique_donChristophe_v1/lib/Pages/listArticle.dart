import 'package:boutique_zando/Pages/FormulaireUser.dart';
import 'package:boutique_zando/Pages/ajouterArticlePage.dart';
import 'package:boutique_zando/Pages/modifiyrArticlePage.dart';
import 'package:boutique_zando/utils/utilitaires.dart';
import 'package:boutique_zando/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/article_controller.dart';
import '../controllers/categorie_controller.dart';
import '../utils/espace.dart';

var idArticle;
var nomCat;

class ListeArticles extends StatefulWidget {
  const ListeArticles({Key? key}) : super(key: key);

  @override
  State<ListeArticles> createState() => _ListeArticlesState();
}

class _ListeArticlesState extends State<ListeArticles> {
  @override
  Widget build(BuildContext context) {
    var listArticles = context.watch<ArticleController>().listArticles;

    return Scaffold(
      drawer: Drawer(
        child: MenuLateral(),
      ),
      appBar: AppBar(
        backgroundColor: Utilitaires.DEFAULT_COLOR,
        title: Text("Articles (${listArticles.length})"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return AjouterArticlePage();
                }));
              },
              iconSize: 40,
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Espace(hauteur: 10),
          Expanded(child: listeUsersView(context))
        ],
      ),
    );
  }

  listeUsersView(BuildContext context) {
    var listArticles = context.watch<ArticleController>().listArticles;
    var tab = context.watch<ArticleController>().tableNomsArticles;
    print("list nom : $tab");
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listArticles.length,
        itemBuilder: (context, index) {
          var couleur = index % 2 == 0
              ? Colors.transparent
              : Colors.purpleAccent.withOpacity(0.2);
          var article = listArticles[index];
          var idcat = article.id;
          return Container(
            color: couleur,
            child: ListTile(
              leading: Icon(
                Icons.article,
                size: 30,
              ),
              title: Text(
                '${article.nom}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Row(
                children: [
                  Text(
                    'PU : ${article.pu}\$',
                    style: TextStyle(fontSize: 15),
                  ),
                  Espace(
                    largeur: 10,
                  ),
                  Text(
                    'Qte : ${article.quantite_initial}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    ' Cat : ${nomCat}',
                    style: TextStyle(fontSize: 15),
                  ),
                  IconButton(
                    onPressed: () {
                      print(article.id);
                      context
                          .read<ArticleController>()
                          .supprimerArticle(article);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ModifyArticlePage(data: article);
                  }));
                },
                icon: Icon(Icons.edit),
              ),
            ),
          );
        });
  }
}
