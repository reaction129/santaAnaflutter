
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
import 'package:http/http.dart' as http;
import 'package:santaana/tabs/gpscarTab.dart';
import 'package:santaana/tabs/pedidosTab.dart';
import 'package:santaana/tabs/valoracionesTab.dart';
import 'package:santaana/tabs/enviarValoracion.dart';
import 'main.dart';
import 'package:santaana/tabs/cambiarPass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:santaana/pages/repartidorPage.dart';
import 'package:oktoast/oktoast.dart';

void main() => runApp(loginsantaAna());

String ID;
String passw;
String nombre;
String perfilUser;





class loginsantaAna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: ('LOGIN'),
      home: new loginPage(),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => new santaAna(idUsuario: ID, nombreUsuario: nombre, perfil: perfilUser),
        '/pages/clientePage': (BuildContext context) => new ClientPage(idUsuario: ID, nombreUsuario: nombre, perfil: perfilUser),
        '/loginPage': (BuildContext context) => loginPage(),
        '/tabs/gpscarTab': (BuildContext context) => gpscarTab(),
        '/tabs/pedidosTab': (BuildContext context) => pedidos(),
        '/tabs/valoracionesTab': (BuildContext context) => ValoracionesTab(),
        '/tabs/enviarValoracion': (BuildContext context) => enviarValoracion(idUsuario: ID, nombreUsuario: nombre,),
        '/tabs/details/cambiarPass': (BuildContext context) => CambiarPass(idUsuario: ID, pass: passw, perfil: perfilUser),
        '/pages/repartidorPage': (BuildContext context) => new RepartidorPage()

}
    );
  }
}


class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}


class _loginPageState extends State<loginPage> {



  final globalKey = new GlobalKey();
  var _formkey = GlobalKey<FormState>();

  TextEditingController rutUser = new TextEditingController();
  TextEditingController passUser = new TextEditingController();




  String msj = '';





  Future <List>login(BuildContext context) async {

    final response = await http.post(
        "http://nuestropandecadadia.com/login.php",
        body: {
          'rut': rutUser.text,
          'pass': passUser.text
        });

    var datauser = json.decode(response.body);
    print(datauser);

    try{
      setState((){
        ID = datauser[0]['idUsuario'];
        nombre = datauser[0]['nombre'];
      });
    }catch (e){
      String ans = "Error ingrese datos validos";
      print(ans);

    }

    if (datauser.length == 0) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => new loginPage()
        ));

    } else {
      if (datauser[0]['perfil'] == 'Administrador') {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => new santaAna(idUsuario: ID, nombreUsuario: nombre, perfil: perfilUser)
        ));
      } else if (datauser[0]['perfil'] == 'Cliente') {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => new ClientPage(idUsuario: ID, nombreUsuario: nombre, perfil: perfilUser)
        ));
      }else if (datauser[0]['perfil'] == 'Repartidor'){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => new RepartidorPage(idUsuario: ID, nombreUsuario: nombre)
        ));
      }

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
                      new RaisedButton(

                        child: new Text('ENTRAR'),
                        color: Colors.orange,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)
                        ),
                        onPressed: () async {
                          login(context);
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new loginsantaAna()
                          ));
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

