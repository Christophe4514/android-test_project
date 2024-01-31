import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


TextEditingController date = TextEditingController();
DateTime? dateChoisie;
var formKey = GlobalKey<FormState>();
class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Container(
        child: formulaire(context)
        ,),
    );
  }

  formulaire(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [zoneDeSaisie()],
        ),
      ),
    );

    ;
  }

  zoneDeSaisie() {
    return TextFormField(
      readOnly: true,
      controller:date,
      validator: (String? val) {
        var tempVal = val ?? "";
        if (tempVal.isEmpty) {
          return "Ce champ est vide";
        }
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                ouvrirCalendrier(context);
              },
              icon: Icon(Icons.calendar_month)),
          border: OutlineInputBorder(),
          hintText: "Champ Obligatoire",
          labelText: "Champs de saisie"),
    );
  }

  ouvrirCalendrier(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateChoisie ?? DateTime.now(),
        firstDate: DateTime(2020),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));
    // traitement des infos de la selection
    if (pickedDate != null) {
      print(pickedDate);
      dateChoisie = pickedDate;
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate);
      date.text = formattedDate;

      setState(() {});
    }
  }

  void validerFormulaire() {
    FormState? etatFormulaire = formKey.currentState;

    if (!etatFormulaire!.validate()) {
      // showSnackBar(context, "Certains champs ne sont pas valides", false);
      return;
    }
    var saisieText = date.text;
    showSnackBar(context, "Valeur recuperée: $saisieText");
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
}





