import 'package:boutique_zando/controllers/operations_controller.dart';
import 'package:boutique_zando/utils/espace.dart';
import 'package:boutique_zando/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utilitaires.dart';
import '../widgets/StatistiqueWidget.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  EdgeInsets paddingVal = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
  List<String> listeTypesTransaction = ['Achat/Vente', "Achat", "Vente"];
  String typeTransactionSelectionne = 'Achat/Vente';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //context.read<ArticleController>().recupererArticlesApi();
      // code executé une seule fois quand la page est lancée
      // ne fonctionne pas avec Ctrl+S quand vous voulez actualiser la pge
      // utilisé pour exploiter la variable context
    });
  }

  @override
  Widget build(BuildContext context) {
    var listOperations = context.watch<OperationController>().listOperations;
    var listAchats = context.watch<OperationController>().listAchats;
    var listVente = context.watch<OperationController>().listVentes;
    context.read<OperationController>().transactions();
    //context.read<OperationController>().progression();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Utilitaires.DEFAULT_COLOR,
        drawer: Drawer(
          child: MenuLateral(),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Zando Online'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.account_balance),
            ),
            IconButton(
                onPressed: () {
                  //context.read<ArticleController>().recupererArticlesApi();
                },
                icon: Icon(Icons.sync))
          ],
        ),
        body: Column(
          children: <Widget>[
            Espace(
              hauteur: 20,
            ),
            enteteRecherche(),
            Espace(
              hauteur: 10,
            ),
            statsCaisse(context),
            Espace(
              hauteur: 10,
            ),
            lignesStatistiques(context),
            enteteListeTransactions(context),
            Expanded(
                child: Container(
                    color: Colors.white,
                    child: (typeTransactionSelectionne == "Achat")
                        ? listeTransactionsAchat(context, listAchats)
                        : (typeTransactionSelectionne == "Vente")
                            ? listeTransactionsVente(context, listVente)
                            : listeTransactions(context, listOperations)))
          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  enteteRecherche() {
    return Container(
      padding: paddingVal,
      //color: Colors.grey.withOpacity(.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.left,
              style: TextStyle(fontStyle: FontStyle.normal),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  iconColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Effectuez une recherche...",
                  fillColor: Colors.white),
            ),
          ),
          Espace(
            largeur: 20,
          ),
        ],
      ),
    );
  }

  lignesStatistiques(BuildContext context) {
    var progressionAchat =
        context.watch<OperationController>().progressionAchats;

    var progressionVentes =
        context.watch<OperationController>().progressionVentes;
    var achat = context.watch<OperationController>().achat;
    var vente = context.watch<OperationController>().vente;
    var benef = context.watch<OperationController>().benef;

    print("pro. Vente : $progressionVentes");
    print("pro. Achat : $progressionAchat");
    return Container(
      height: 80,
      //color: Colors.red,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 250,
            //le Widget pour card
            child: StatistiqueWidget(
              titre: "Depenses",
              valeur: achat,
              progression: progressionAchat,
            ),
          ),
          Container(
            width: 250,
            //le Widget pour card
            child: StatistiqueWidget(
              titre: "Revenus",
              valeur: vente,
              progression: progressionVentes,
            ),
          ),
          Container(
            width: 250,
            //le Widget pour card
            child: StatistiqueWidget(
              titre: "Benefice",
              valeur: benef,
              progression: 0,
              isBenefice: true,
            ),
          ),
        ],
      ),
    );
  }

  enteteListeTransactions(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: paddingVal.copyWith(left: 2, right: 2),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sync),
          ),
          Text(
            "10 Dern. Trans.",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Spacer(),
          selectionTypeTransaction(context)
        ],
      ),
    );
  }

  statsCaisse(BuildContext context) {
    var sommeCaisse = context.watch<OperationController>().caisse;
    return Container(
      //color: Colors.transparent,
      padding: paddingVal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mon Portefeuille',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              Text(
                'A date: 01/01/2020',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12),
              )
            ],
          ),
          Text(
            'USD ${Utilitaires.formatAmount(sommeCaisse)}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
          )
        ],
      ),
    );
  }

  listeTransactions(BuildContext context, List listOperations) {
    var listTemp = listOperations.take(10);

    return ListView.builder(
      itemCount: listTemp.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.shop,
            size: 35,
          ),
          title: Text(
            (listOperations[index].isAchat)
                ? 'Achat : ${listOperations[index].nomArticle}'
                : 'Vente : ${listOperations[index].nomArticle}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${listOperations[index].dateOperation}",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          trailing: Text(
            "${listOperations[index].pOperation}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green),
          ),
        );
      },
    );
  }

  listeTransactionsAchat(BuildContext context, List listAchat) {
    var listTemp = listAchat.take(10);
    return ListView.builder(
      itemCount: listTemp.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.remove_circle,
            size: 35,
          ),
          title: Text(
            (listAchat[index].isAchat)
                ? 'Achat : ${listAchat[index].nomArticle}'
                : 'Vente : ${listAchat[index].nomArticle}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${listAchat[index].dateOperation}",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          trailing: Text(
            "${listAchat[index].pOperation}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green),
          ),
        );
      },
    );
  }

  listeTransactionsVente(BuildContext context, List listVente) {
    var listTemp = listVente.take(10);
    return ListView.builder(
      itemCount: listTemp.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.remove_circle,
            size: 35,
          ),
          title: Text(
            (listVente[index].isAchat)
                ? 'Achat : ${listVente[index].nomArticle}'
                : 'Vente : ${listVente[index].nomArticle}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${listVente[index].dateOperation}",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          trailing: Text(
            "${listVente[index].pOperation}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green),
          ),
        );
      },
    );
  }

  selectionTypeTransaction(BuildContext context) {
    return DropdownButton(
      value: typeTransactionSelectionne,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: listeTypesTransaction.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          typeTransactionSelectionne = newValue!;
        });
      },
    );
  }
}
