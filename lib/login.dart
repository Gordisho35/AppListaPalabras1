import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lista_palabras_app/menu.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  String email = '';
  String clave = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.yellowAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3, color: Colors.blue)),
              child: SvgPicture.asset(
                'assets/imgs/logo.svg',
                height: 250.0,
              ),
            )),
            Column(
              children: const [
                Text('Generador de Palabras',
                    style: TextStyle(fontSize: 35, color: Colors.deepPurple)),
                Text('Inicie sesión',
                    style: TextStyle(fontSize: 25, color: Colors.blueGrey)),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextField(
                    onChanged: (value) => email = value,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(
                        CupertinoIcons.mail,
                      ),
                      hintText: 'ejemplo@email.co',
                      labelText: 'Correo Electrónico',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextField(
                    onChanged: (value) => clave = value,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(
                        CupertinoIcons.lock_fill,
                      ),
                      hintText: 'Clave de 8 dígitos',
                      labelText: 'Contraseña',
                      iconColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            MaterialButton(
              elevation: 10.0,
              minWidth: 300.0,
              height: 50.0,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: const Text('Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              onPressed: () {
                if (email != 'gordisho@gmail.com' || clave != 'gordisho123') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Usuario o contraseña incorrectos'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const [
                              Text('Verifica tus datos'),
                            ],
                          ),
                        ),
                        actions: [
                          MaterialButton(
                              child: const Text('Aceptar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const MenuScreen();
                  }));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
