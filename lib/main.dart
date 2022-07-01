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
      home: const ParPalabras(),

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
  
  //itemSet es una coleccion Set para guardar los pares de palabras
  //que el usuario va a marcar como favorito. SEt no permite duplicados
  final _itemSet = <WordPair>{};
  final _filasPalbras = <WordPair>[];
  final _letraGrande = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
   //final palabra = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Generador de listas de palabras'),
           actions: [
            IconButton(onPressed: _agregarFavorito,
             icon: const Icon(Icons.list),
             tooltip: 'Favoritos guardados',
             )
           ],       
      ), 
      body: ListView.builder(
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
            
            //La variable parExiste verifica que un par de palabras no
            //hayan sido agragados aun al Set _itemSet
            //El metodo contains() busca segun su criterio y 
            //devuelve true o false.
            final parExiste = _itemSet.contains(_filasPalbras[index]);
            return ListTile(
              title: Text(
                _filasPalbras[index].asPascalCase,
                style: _letraGrande,
              ),
              trailing: Icon(
                parExiste ? Icons.favorite : Icons.favorite_border,
                color: parExiste ? Colors.blue : null,
                semanticLabel: parExiste ? 'Remover de favoritos':'Agregar a favoritos',
              ),

              onTap: (){
                setState(() {
                  if(parExiste) {
                    _itemSet.remove(_filasPalbras[index]);
                  }else {
                    _itemSet.add(_filasPalbras[index]);
                  }
                });
              },
            );
          },
        ),
      );
    
  }

  void _agregarFavorito(){

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final filaFavorito = _itemSet.map((par) {
            return ListTile(
              title: Text(
                par.asPascalCase,
                style: _letraGrande,
              ),
            );
          }
        );
        final divisor = filaFavorito.isNotEmpty
        ? ListTile.divideTiles(
          context: context,
          tiles: filaFavorito
        ).toList()
       : <Widget> [];

       return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de favoritos guardados'),
        ),

        body: ListView(
          children: divisor,
        ),
       );
      }));
   }
}
