import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:santaana/login.dart';
import 'package:santaana/tabs/valoracionesTab.dart';
import 'package:santaana/tabs/gpscarTab.dart';
import 'package:santaana/tabs/pedidosTab.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/tabs/cambiarPass.dart';
import 'package:santaana/tabs/carTab.dart';

//void main() => runApp(santaAna());


class santaAna extends StatefulWidget {
  final String idUsuario;
  final String nombreUsuario;
  final String perfil;
  santaAna({this.idUsuario, this.nombreUsuario, this.perfil});


  @override
  _santaAnaState createState() => _santaAnaState();
}

class _santaAnaState extends State<santaAna> {
  @override
  Widget build(BuildContext context) {


    final TabController = new DefaultTabController(

      length: 3,
      child: new Scaffold(
        drawer: Drawer(

          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("BIENVENIDO"),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.orange : Colors.brown,
                  child: Text(":)",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ListTile(
              title: Text("Cambiar mi contraseña"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => new CambiarPass(idUsuario: ID, perfil: perfilUser)
                ));
              },
            )

            ],
          ),
        ),

        appBar: new AppBar(
          title: new Text('Panaderia Santa Ana'),
          bottom: new TabBar(indicatorColor: Colors.black12, tabs: <Widget>[
            new Tab(icon: new Icon(Icons.warning), text: "Atencion al Cliente",),
            new Tab(icon: new Icon(Icons.location_on), text: "Rastreo Vehicular",),
            new Tab(icon: new Icon(Icons.whatshot), text: "Pedidos",),

          ],),
        ),

        body: new TabBarView(
          children: <Widget>[
            new ValoracionesTab(),
            new CarsTabs(),
            new pedidos()
          ],
        ),

      ),

    );

    return new MaterialApp(
      title: ('Panaderia Santa ANA'),
      theme: new ThemeData(
          primarySwatch: Colors.brown
      ),
      home: TabController,

    );
  }
}

