import 'package:boutique_zando/Pages/FormulaireUser.dart';
import 'package:boutique_zando/Pages/ajouterArticlePage.dart';
import 'package:boutique_zando/Pages/creerOperationPage.dart';
import 'package:boutique_zando/Pages/modifiyrArticlePage.dart';
import 'package:boutique_zando/controllers/operations_controller.dart';
import 'package:boutique_zando/utils/utilitaires.dart';
import 'package:boutique_zando/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/article_controller.dart';
import '../controllers/categorie_controller.dart';
import '../utils/espace.dart';

class ListeOperations extends StatefulWidget {
  const ListeOperations({Key? key}) : super(key: key);

  @override
  State<ListeOperations> createState() => _ListeOperationsState();
}

class _ListeOperationsState extends State<ListeOperations> {
  @override
  Widget build(BuildContext context) {
    var listOperations = context.watch<OperationController>().listOperations;

    return Scaffold(
      drawer: Drawer(
        child: MenuLateral(),
      ),
      appBar: AppBar(
        backgroundColor: Utilitaires.DEFAULT_COLOR,
        title: Text("Operations (${listOperations.length})"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CreerOperationPage();
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
    var listOperations = context.watch<OperationController>().listOperations;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listOperations.length,
        itemBuilder: (context, index) {
          var couleur = index % 2 == 0
              ? Colors.transparent
              : Colors.purpleAccent.withOpacity(0.2);
          var operation = listOperations[index];

          return Container(
            color: couleur,
            child: ListTile(
              leading: Icon(
                Icons.article,
                size: 30,
              ),
              title: Text(
                (operation.isAchat)
                    ? 'Achat : ${operation.nomArticle}'
                    : 'Vente : ${operation.nomArticle}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '${operation.dateOperation}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Espace(
                    largeur: 10,
                  ),
                  Text(
                    'Qte : ${operation.qteOperation}',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              trailing: Container(
                child: (operation.isAchat)
                    ? Text(
                        "${operation.pOperation}\$",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "${operation.pOperation}\$",
                        style: TextStyle(fontSize: 15),
                      ),
              ),
            ),
          );
        });
  }
}
