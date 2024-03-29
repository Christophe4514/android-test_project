import 'dart:ui';

class Utilitaires {
  static const Color DEFAULT_COLOR = Color.fromRGBO(
      2, 62, 138, 0.7098039215686275);

  static String formatAmount(double valeurNumerique) {
    // cette methode peut etre etre remplacée par le package Intl
    // qui offre mieux et gerer plusieurs fonctionnalités
    //https://pub.dev/packages/intl
    String valeurNumeriqueTemp = valeurNumerique.toInt().toString();
    String priceInText = "";
    int counter = 0;
    for (int i = (valeurNumeriqueTemp.length - 1); i >= 0; i--) {
      counter++;
      String str = valeurNumeriqueTemp[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }
}
