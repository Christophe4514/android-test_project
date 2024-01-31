class ArticleModel {
  int? id;
  String nom;
  int quantite_initial;
  double pu;

  ArticleModel(
      {this.id,
      required this.nom,
      required this.quantite_initial,
      required this.pu});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"] == null ? null : json["id"],
        nom: json["nom"] == null ? null : json["nom"],
        quantite_initial: json["qte"] == null ? null : json["qte"],
        pu: json["pu"] == null ? null : json["pu"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "nom": nom == null ? null : nom,
        "qte": quantite_initial == null ? null : quantite_initial,
        "pu": pu == null ? null : pu,
      };
}
