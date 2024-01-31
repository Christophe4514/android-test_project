import 'package:boutique_zando/controllers/operations_controller.dart';
import 'package:boutique_zando/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/intro_page.dart';
import 'controllers/activite_controller.dart';
import 'controllers/article_controller.dart';

void main() {
  //await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleController()),
        // declaration deuxieme controlleur
        ChangeNotifierProvider(create: (context) => UserController()),

        ChangeNotifierProvider(create: (context) => ActiviteController()),

        ChangeNotifierProvider(create: (context) => OperationController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
        //home: Accueil(),// pour test
      ),
    );
  }
}
