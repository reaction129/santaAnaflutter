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

class DetailRastreo extends StatefulWidget {
  List list;
  int index;
  DetailRastreo({this.index, this.list});
  @override
  _DetailRastreoState createState() => _DetailRastreoState();
}

class _DetailRastreoState extends State<DetailRastreo> {
  var lat;
  var lon;

  Future getCurrentLocation2() async{
    LocationData _currentLocation;
    StreamSubscription<LocationData> _locationSubscription;
    var location = new Location();
    String error;
    _locationSubscription = location.onLocationChanged().listen((LocationData currentLocation) async{
      setState(() {
        _currentLocation = currentLocation;
      });
    });
    _currentLocation = await location.getLocation();
    //print(_currentLocation.latitude);
    // print(_currentLocation.longitude);
    lat = _currentLocation.latitude;
    lon=_currentLocation.longitude;

    try{
      var url = "http://nuestropandecadadia.com/getLocation.php";
      http.post(url, body: {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'idVehiculo': widget.list[widget.index]['idVehiculo']
      });
    }catch (e){
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.directions_car),
              onPressed: (){
                getCurrentLocation2();
              },
            )
          ],
        ),


    );

  }
}
