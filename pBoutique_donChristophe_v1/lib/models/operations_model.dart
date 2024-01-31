import 'package:boutique_zando/models/article_model.dart';

class OperationsModel {
  int? idOperation;
  bool isAchat;
  String dateOperation;
  String nomArticle;
  int qteOperation;
  double pOperation;

  OperationsModel(
      {required this.dateOperation,
      required this.isAchat,
      required this.nomArticle,
      required this.pOperation,
      required this.qteOperation,
      this.idOperation});

  factory OperationsModel.fromJson(Map<String, dynamic> json) =>
      OperationsModel(
        idOperation: json["id"] == null ? null : json["id"],
        nomArticle: json["nom"] == null ? null : json["nom"],
        qteOperation: json["qte"] == null ? null : json["qte"],
        pOperation: json["pu"] == null ? null : json["pu"].toDouble(),
        isAchat: json["isAchat"] == null ? null : json["isAchat"],
        dateOperation: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nomArticle == null ? null : nomArticle,
        "qte": qteOperation == null ? null : qteOperation,
        "pu": pOperation == null ? null : pOperation,
        "isAchat": isAchat == null ? null : isAchat,
        "created_at": dateOperation == null ? null : dateOperation,
      };
}
