import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:santaana/tabs/details/detailValoracion.dart';
import 'package:santaana/tabs/details/detailVehiculo.dart';
import 'package:santaana/main.dart';


class CarsTabs extends StatefulWidget {
  @override
  _CarsTabsState createState() => _CarsTabsState();
}

class _CarsTabsState extends State<CarsTabs> {

  Dio dio = new Dio();
  Response response;

  Future<List> getCars()async{
    var url= 'http://nuestropandecadadia.com/getCars.php';
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
        title: new Text("Vehiculos"),
      ),
      body: new FutureBuilder<List>(
        future: getCars(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new carList(
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

class carList extends StatelessWidget {
  final List list;
  carList({this.list});



  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i){
          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailVehiculo(
                    list: list,
                    index: i,
                  )
              )),
              child: new Card(
                child: new ListTile(
                  title: new Text(
                    list[i]['marca'],
                    style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                  ),
                  leading: new Icon(
                    Icons.assignment_late,
                    size: 45.0,
                    color: Colors.orangeAccent,
                  ),
                  subtitle: new Text(
                    "Patente: ${list[i]['patente']}",
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
