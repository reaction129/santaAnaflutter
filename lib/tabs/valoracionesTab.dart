import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:santaana/tabs/details/detailValoracion.dart';

class ValoracionesTab extends StatefulWidget {


  @override
  _ValoracionesTabState createState() => _ValoracionesTabState();
}

class _ValoracionesTabState extends State<ValoracionesTab> {

  Dio dio = new Dio();
  Response response;

  Future<List> getValoraciones()async{
    var url= 'http://nuestropandecadadia.com/getValoraciones.php';
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
        title: new Text("Opiniones de los clientes"),
      ),
      body: new FutureBuilder<List>(
        future: getValoraciones(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new valoracionList(
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


class valoracionList extends StatelessWidget {
  final List list;
  valoracionList({this.list});



  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i){
          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailValoracion(
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
                    "Opinion del servicio: ${list[i]['nivel']}",
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


