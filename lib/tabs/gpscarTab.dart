import 'dart:async';
import 'dart:convert';
import 'package:permission/permission.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';






class gpscarTab extends StatefulWidget {

  @override
  _gpscarTabState createState() => _gpscarTabState();
}

class _gpscarTabState extends State<gpscarTab> {

  GoogleMapController mapController;
  Set<Marker> markers = Set();



  void getCurrentLocation() async{
    var location = new Location();
    try {
      await location.getLocation().then((onValue) {
        print(onValue.latitude.toString() + "," + onValue.longitude.toString());
      });
    } catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        print("Active GPS");
      }
    }
  }

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

   Marker resultMarker = Marker(
     icon: BitmapDescriptor.defaultMarker,
     markerId: MarkerId("1"),
     infoWindow: InfoWindow(
       title: "XG7191",
     ),
     position: LatLng(lat,lon),
   );
   setState(() {
     markers.add(resultMarker);
   });



 }

 // Future<List> getCars() async{
 //   var response = new Response();
 //   Dio dio = new Dio();
 //   var url= 'http://localhost:8888/santaAnaflutter/getCars.php';
  //  try{
 //     response = await dio.get(url);
  //    return jsonDecode(response.data);
//
  //  }catch (e){
  //    print(e.toString());
 //   }
//
 // }



  void _onMapCreated(GoogleMapController controller){
    mapController = controller;

    GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(0,0)),
       markers: markers,
    );
    }

    void addMarker() async{
    }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.directions_car),
            tooltip: 'CITROENC15 XG7194',
            onPressed: (){
              getCurrentLocation2();

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
