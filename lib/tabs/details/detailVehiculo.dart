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

class DetailVehiculo extends StatefulWidget {
  List list;
  int index;
  DetailVehiculo({this.index, this.list});
  @override
  _DetailVehiculoState createState() => _DetailVehiculoState();
}

class _DetailVehiculoState extends State<DetailVehiculo> {
  var lat;
  var lon;
  Set<Marker> markers = Set();
  GoogleMapController mapController;


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

  void updateCurrentLocation() async{
    var latMarker;
    var lonMarker;
    Response response;
    Dio dio = new Dio();
    var url = "http://nuestropandecadadia.com/updateLocation.php";


    try{
      response = await dio.get(url, queryParameters: {'idVehiculo': widget.list[widget.index]['idVehiculo']});
      List<dynamic> pos = json.decode(response.data);
      for(var auto in pos){
        latMarker=double.parse(auto['lat']);
        lonMarker=double.parse(auto['lon']);
      }
    }catch (e){
      print(e.toString());
    }

    Marker resultMarker = Marker(
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId(widget.list[widget.index]['idVehiculo']),
      infoWindow: InfoWindow(
        title: (widget.list[widget.index]['patente']),
      ),
      position: LatLng(latMarker, lonMarker),
    );
    setState(() {
      markers.remove(resultMarker);
      markers.add(resultMarker);

    });


  }



  @override
  Widget build(BuildContext context) {

    print(widget.list[widget.index]['idVehiculo']);
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.directions_car),
            onPressed: (){
              updateCurrentLocation();
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          height:  MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            markers: markers,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(-35.436324, -71.624135),
              zoom: 12.0,
            ),


          ),
        ),
      ),

    );

  }
}

