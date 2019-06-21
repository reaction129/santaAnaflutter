import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/tabs/details/registrarPedido.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'details/detailPedido.dart';


class pedidos extends StatefulWidget {



  @override
  _pedidosState createState() => _pedidosState();
}

class _pedidosState extends State<pedidos> {

 Dio dio = new Dio();
 Response response;

  Future<List> getPedidos()async{
    var url= 'http://nuestropandecadadia.com/getPedido.php';
    try{
      response = await dio.get(url);
      return json.decode((response.data));

    }catch (e){
      print(e.toString());
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Listado de pedidos"),
      ),
      body: new FutureBuilder<List>(
        future: getPedidos(),
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
                  list[i]['nombreUsuario'],
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.assignment_late,
                  size: 45.0,
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

