
import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:santaana/pages/adminPage.dart';
import 'package:santaana/pages/clientePage.dart';
import 'package:santaana/pages/despachadorPage.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/tabs/gpscarTab.dart';
import 'package:santaana/tabs/pedidosTab.dart';
import 'package:santaana/tabs/valoracionesTab.dart';

import 'main.dart';


void main() => runApp(loginsantaAna());

String rut;


class loginsantaAna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: ('LOGIN'),
      home: new loginPage(),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => new santaAna(rut: rut,),
        '/adminPage': (BuildContext context) => new Admin(),
        '/clientePage': (BuildContext context) => new Client(),
        '/despachadorPage': (BuildContext context) => new Despachador(),
        '/loginPage': (BuildContext context) => loginPage(),
        '/tabs/gpscarTab': (BuildContext context) => gpscarTab(),
        '/tabs/pedidosTab': (BuildContext context) => pedidos(rut: rut,),
        '/tabs/valoracionesTab': (BuildContext context) => valoracionesTab()

      },

    );
  }
}


class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}


class _loginPageState extends State<loginPage> {



  TextEditingController rutUser = new TextEditingController();
  TextEditingController passUser = new TextEditingController();



  String msj = '';



  Future<List> login(BuildContext context) async {
    final response = await http.post(
        "http://localhost:8888/santaAnaflutter/login.php",
        body: {
          'rut': rutUser.text,
          'pass': passUser.text,

        });
    var datauser = json.decode(response.body);
    print(datauser);

    if (datauser.length == 0) {
      setState(() {
        msj = "Login Fail";
      });
    } else {
      if (datauser[0]['perfil'] == 'Administrador') {
        Navigator.pushReplacementNamed(context, '/main');
      } else if (datauser[0]['nivel'] == 'bodega') {
//        Navigator.pushReplacementNamed(context, '/bodegaPage');
      }

      setState(() {
        rut = datauser[0]['rut'];
      });
    }

    return datauser;
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(

        resizeToAvoidBottomPadding: false,
        body: Form(
          child: Container(
            decoration: new BoxDecoration(
              //insertar img por web aca
            ),
            child: Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 77.0),
                  child: new CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,

                  ),
                ),
                new Container(

                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: EdgeInsets.only(
                      top: 93
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.2,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4
                        ),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5
                              )
                            ]
                        ),

                        child: TextField(
                          controller: rutUser,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.black,
                              ),
                              hintText: 'RUT'
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.2,
                        height: 50,
                        margin: EdgeInsets.only(
                            top: 32
                        ),
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5
                              )
                            ]
                        ),
                        child: TextField(
                          controller: passUser,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.vpn_key,
                                color: Colors.black,
                              ),
                              hintText: 'Contraseña'
                          ),
                        ),

                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            right: 32,
                          ),
                          child: Text(
                            'Recordar contraseña',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      new RaisedButton(
                        child: new Text('ENTRAR'),
                        color: Colors.orange,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)
                        ),
                        onPressed: () {
                          login(context);
                          Navigator.pop(context);
                        },
                      ),
                      Text(msj,
                        style: TextStyle(
                            fontSize: 25.0, color: Colors.deepOrange),
                      )
                    ],
                  ),

                )
              ],
            ),
          ),
        ),
      );
    }
  }

