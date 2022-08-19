import 'package:flutter/material.dart';
import 'package:lista_palabras_app/login.dart';

void main() {
  runApp(const AppListaPalabras());
}

class AppListaPalabras extends StatelessWidget {
  const AppListaPalabras({Key? key}) : super(key: key); // constructor

  @override
  Widget build(BuildContext context) {
    //necesario para mostrar la pantalla del app
    //final palabra = WordPair.random();
    return MaterialApp(
      title: 'Generador de listas de palabra',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
