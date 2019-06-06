
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class gpscarTab extends StatefulWidget {

  @override
  _gpscarTabState createState() => _gpscarTabState();
}

class _gpscarTabState extends State<gpscarTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
          title: new Text('Rastreo Vehicular')),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-35.436324, -71.624135),
              zoom: 12.0

            ),
          ),
        ),
      ),




        );

  }
}
