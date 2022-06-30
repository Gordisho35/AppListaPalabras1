import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
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
          foregroundColor: Colors.black,

        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Generador de listas de palabras'),
                  
      ), 
      body: const Center(
        //body: const Center(
        //child: Text('Hola mundo les saluda el Gordisho'),
        //child: Text(palabra.asPascalCase),
        child: ParPalabras(),
      ),
      ),

    );
  }
  
}
// Creamos la clase ParPalabras y un StatefulWidget
class ParPalabras extends StatefulWidget{
   const ParPalabras({Key? key}) : super(key: key);
   
     @override
     State<StatefulWidget> createState() => _ParPalabras();
   
}
// Esta clase es para el manejo del estado del widget ParPalabras
class _ParPalabras extends State <ParPalabras>{
  final _filasPalbras = <WordPair>[];
  final _letraGrande = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
   //final palabra = WordPair.random();
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        
        //si el item es impar, dibuja una linea de division
        if(i.isOdd) return const Divider();

        //verifica si estoy al final de la lista
        //genera 10 filas adicionales
        final index = i ~/ 2; 
        // divede i/2 y retorna un entero, omite la parte decimal
        if(index>=_filasPalbras.length) {
          _filasPalbras.addAll(generateWordPairs().take(10));
        }
        return ListTile(
          title: Text(
            _filasPalbras[index].asPascalCase,
            style: _letraGrande,
          ),
        );
      },
    ); 
  }
}