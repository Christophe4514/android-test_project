import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserController with ChangeNotifier {
  final stockage = GetStorage();

  List<UserModel> listUsers = [
    UserModel(id: 1, name: "admin", password: "admin", genre: "", isAdmin: true)
  ];

  void ajouterUser(UserModel data) {
    data.id = listUsers.length + 1;
    listUsers.add(data);
    notifyListeners();
  }

  bool authentifier(String name, String motDePasse) {
    var resultat = listUsers
        .where((e) => e.name == name && e.password == motDePasse)
        .toList();
    return resultat.length == 0 ? false : true;
  }

  authentifierParInternet(String name, String motDePasse) async {
    var url = Uri(
        scheme: "http",
        host: "10.224.196.138",
        path: "/api_flutter/authentification.php");
    Map data = {"username": name, "password": motDePasse};
    var requete = await http.post(url, body: json.encode(data));
    print(requete.body);
    //return
  }

  bool checkStatusConnextion() {
    bool? status = stockage.read<bool>('is_connected');
    return status ?? false;
  }

  changerStatusConnexion(bool status) {
    stockage.write("is_connected", status);
    notifyListeners();
  }
}
