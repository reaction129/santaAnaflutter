import 'dart:async';
import 'dart:convert';
import 'package:permission/permission.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:santaana/tabs/details/detailRastreo.dart';


class RepartidorPage extends StatefulWidget {
  var idUsuario;
  var nombreUsuario;

  RepartidorPage({Key key, this.idUsuario, this.nombreUsuario});

  @override
  _RepartidorPageState createState() => _RepartidorPageState();
}

class _RepartidorPageState extends State<RepartidorPage> {
  var lat;
  var lon;
  GoogleMapController mapController;

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
        title: new Text("Seleccione vehiculo a manejar"),
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
                  builder: (BuildContext context) => new DetailRastreo(
                    list: list,
                    index: i,
                  )
              )),
              child: new Card(
                child: new ListTile(
                  title: new Text(
                    list[i]['modelo'],
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

