import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ParPalabras extends StatefulWidget {
  const ParPalabras({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ParPalabrasState();
}

//manejo del estado del widget ParPalabras
class _ParPalabrasState extends State<ParPalabras> {
  //_itemSet es una coleccion Set para guardar
  //los pares de palabras, que el usuario va a
  //marcar como favoritos. Set no permite duplicados
  final _itemSet = <WordPair>{};
  final _filasPalabra = <WordPair>[];
  final _letraGrande = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    //final palabra = WordPair.random();
    //return Text(palabra.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador Lista de Palabras'),
        actions: [
          IconButton(
            onPressed: _agregarFavorito,
            icon: const Icon(CupertinoIcons.list_bullet),
            tooltip: 'Favoritos guardados',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          //si el item es impar, dibuja una linea de division
          if (i.isOdd) return const Divider();
          //verifica si estoy al final de la lista
          //genera 10 filas adicionales
          final index = i ~/ 2;
          //i ~/ 2 lo que hace es dividir i entre 2 y
          //retorna un int como resultado, omite totalmente la parte decimal
          if (index >= _filasPalabra.length) {
            _filasPalabra.addAll(generateWordPairs().take(10));
          }
          //la variable parExiste verifica que un par de
          //palabras no hayan sido agregados aun al Set _itemSet
          //el metodo contains() busca segun el criterio y
          //devuelve true o false
          final parExiste = _itemSet.contains(_filasPalabra[index]);

          return ListTile(
            tileColor: parExiste ? Colors.green.shade400 : Colors.white,
            textColor: parExiste ? Colors.white : Colors.black,
            title: Text(
              _filasPalabra[index].asPascalCase,
              style: _letraGrande,
            ),
            trailing: Icon(
              parExiste ? CupertinoIcons.star_fill : CupertinoIcons.star,
              color: parExiste ? Colors.amber : null,
              semanticLabel:
                  parExiste ? 'Remover de favoritos' : "Agregar a favoritos",
            ),
            onTap: () {
              setState(() {
                if (parExiste) {
                  _itemSet.remove(_filasPalabra[index]);
                } else {
                  _itemSet.add(_filasPalabra[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void _agregarFavorito() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final filaFavorito = _itemSet.map((par) {
        return ListTile(
          trailing: const Icon(CupertinoIcons.star_fill, color: Colors.amber),
          title: Text(
            par.asPascalCase,
            style: _letraGrande,
          ),
        );
      });
      final divisor = filaFavorito.isNotEmpty
          ? ListTile.divideTiles(context: context, tiles: filaFavorito).toList()
          : <Widget>[
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  'No se ha seleccionado ninguna palabra como favorita!',
                  style: _letraGrande,
                ),
              )
            ];

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
