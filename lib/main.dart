import 'package:flutter/material.dart';
import 'package:santaana/tabs/valoracionesTab.dart';
import 'package:santaana/tabs/gpscarTab.dart';
import 'package:santaana/tabs/pedidosTab.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(santaAna());


class santaAna extends StatefulWidget {
  santaAna({this.rut});
  final String rut;

  @override
  _santaAnaState createState() => _santaAnaState();
}

class _santaAnaState extends State<santaAna> {
  @override
  Widget build(BuildContext context) {
    final TabController = new DefaultTabController(

      length: 3,
      child: new Scaffold(

        appBar: new AppBar(
          title: new Text('Panaderia Santa Ana'),
          bottom: new TabBar(indicatorColor: Colors.black12, tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.warning), text: "Atenciòn al cliente",),
            new Tab(icon: new Icon(Icons.location_on), text: "Vehiculos",),
            new Tab(icon: new Icon(Icons.whatshot), text: "Pedidos",),

          ],),
        ),

        body: new TabBarView(
          children: <Widget>[
            new gpscarTab(),
            new valoracionesTab(),
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

