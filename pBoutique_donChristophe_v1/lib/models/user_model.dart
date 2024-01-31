class UserModel {
  int? id;
  String name;
  String password;
  String genre;
  bool isAdmin;

  UserModel(
      {this.id,
      required this.name,
      required this.password,
      required this.genre,
      this.isAdmin = false});
}
