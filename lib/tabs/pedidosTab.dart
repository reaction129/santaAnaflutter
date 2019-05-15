import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/tabs/details/registrarPedido.dart';
import 'dart:async';

import 'details/detailPedido.dart';


class pedidos extends StatefulWidget {

  pedidos({this.rut});
  final String rut;
  @override
  _pedidosState createState() => _pedidosState();
}

class _pedidosState extends State<pedidos> {

  Future<List> getDatapedidos() async{
    final response = await http.get("http://localhost:8888/santaAnaflutter/getPedido.php");
    return json.decode((response.body));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Listado de pedidos"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new RegistrarPedido(),
          ));
          },
      ),
      body: new FutureBuilder<List>(
        future: getDatapedidos(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new pedidosList(
            list: snapshot.data
          )
              : new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class pedidosList extends StatelessWidget {
  final List list;
  pedidosList({this.list});



  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Detail(
                list: list,
                index: i,
              )
            )),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['idPedido'],
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.assignment_late,
                  size: 77.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: new Text(
                  "Kilos : ${list[i]['kilos']}",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

