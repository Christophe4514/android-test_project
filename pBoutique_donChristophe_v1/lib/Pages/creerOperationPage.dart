import 'package:boutique_zando/Pages/listOperations.dart';
import 'package:boutique_zando/controllers/article_controller.dart';
import 'package:boutique_zando/controllers/operations_controller.dart';
import 'package:boutique_zando/models/article_model.dart';
import 'package:boutique_zando/models/operations_model.dart';
import 'package:boutique_zando/utils/datepicker.dart';
import 'package:boutique_zando/utils/espace.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreerOperationPage extends StatefulWidget {
  @override
  State<CreerOperationPage> createState() => _CreerOperationPageState();
}

class _CreerOperationPageState extends State<CreerOperationPage> {
  List<String> listeTypesTransaction = ["Achat", "Vente"];
  String typeTransactionSelectionne = 'Achat';
  TextEditingController nomArticle = TextEditingController();
  TextEditingController puOperration = TextEditingController();

  TextEditingController qtyOPeration = TextEditingController();
  String valueDefault = "velo";
  List<ArticleModel> articles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      articles = context.read<ArticleController>().listArticles;
      valueDefault = articles[0].nom;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Espace(
              hauteur: 50,
            ),
            entete(),
            //titreZoneSasie("Nom"),
            Espace(
              hauteur: 10,
            ),
            //titreZoneSasie("Prix unitaire"),

            Espace(
              hauteur: 30,
            ),
            choixOperation(context),
            Espace(
              hauteur: 10,
            ),
            Text(
              "Choisir un article : ",
              style: TextStyle(fontSize: 18),
            ),
            //nomArticleChampSaisie(),
            choixArticle(context, articles.map((e) => e.nom).toList()),
            (typeTransactionSelectionne == "Achat")
                ? prixAChampSaisie(puOperration)
                : prixVChampSaisie(puOperration),
            Espace(
              hauteur: 10,
            ),
            //titreZoneSasie("Quantité"),
            Espace(
              hauteur: 10,
            ),
            quantiteChampSaisie(),
            Espace(
              hauteur: 20,
            ),
            DatePicker(),
            //dateChampSaisie(),
            Espace(
              hauteur: 100,
            ),
            //Spacer(),
            listeButtonsNavivations(context),
          ],
        ),
      ),
    ));
  }

  listeButtonsNavivations(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              // recuperer les valeurs du formulaire et convertir (avec risque de valeur vide)
              String nomText = nomArticle.text;
              double puText = double.parse(puOperration.text);
              int qtyText = int.parse(qtyOPeration.text);
              String dateText = date.text;
              puText *= qtyText;

              print(nomText);
              print(puText);
              print(qtyText);
              var isAchat = true;
              if (typeTransactionSelectionne == "Vente") {
                isAchat = false;
              }
              // creation de l'article avec le model
              var data = OperationsModel(
                  dateOperation: dateText,
                  isAchat: isAchat,
                  nomArticle: valueDefault,
                  pOperation: puText,
                  qteOperation: qtyText);

              // appel de la fonction definie dans le controlleur
              context.read<OperationController>().ajouterOperation(data);
              validerFormulaire();
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ListeOperations();
              }));
            },
            child: Text('Ajouter'),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50))),
      ],
    );
  }

  void validerFormulaire() {
    FormState? etatFormulaire = formKey.currentState;

    if (!etatFormulaire!.validate()) {
      // showSnackBar(context, "Certains champs ne sont pas valides", false);
      return;
    }
    var saisieText = date.text;
    showSnackBar(context, "Transaction effectuée : $saisieText");
  }

  showSnackBar(BuildContext context, String message, [bool success = true]) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      backgroundColor: success ? Colors.green : Colors.red,
      content: Text("$message"),
      action: SnackBarAction(
          label: 'OK',
          textColor: Colors.black,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  Widget entete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Créer une opération",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.add_shopping_cart,
          size: 50,
        )
      ],
    );
  }

  Widget nomArticleChampSaisie() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: nomArticle,
        decoration:
            InputDecoration(labelText: "Nom de l'article", filled: false),
      ),
    );
  }

  Widget dateChampSaisie() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: date,
        decoration: InputDecoration(labelText: "Date", filled: false),
      ),
    );
  }

  Widget prixAChampSaisie(TextEditingController pu) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        controller: puOperration,
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(labelText: "Prix unitaire d'Achat", filled: false),
      ),
    );
  }

  Widget prixVChampSaisie(TextEditingController pu) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        controller: puOperration,
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(labelText: "Prix unitaire de Vente", filled: false),
      ),
    );
  }

  Widget choixOperation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton(
              isExpanded: true,
              value: typeTransactionSelectionne,
              icon: Icon(Icons.keyboard_arrow_down),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget choixArticle(BuildContext context, List<String> Articles) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton(
              isExpanded: true,
              value: valueDefault,
              icon: Icon(Icons.keyboard_arrow_down),
              items: Articles.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  valueDefault = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget quantiteChampSaisie() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: qtyOPeration,
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(labelText: "Quantité de l'article", filled: false),
      ),
    );
  }

  Widget titreZoneSasie(String titre) {
    return Center(
      child: Text(titre, style: TextStyle(fontSize: 25)),
    );
  }
}
