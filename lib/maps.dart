import 'dart:async';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller =Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.red,
        title: Text("شعب دیجی کالا برای دریافت حضوری",
          style: TextStyle(
            fontFamily: "iranyekan",
            fontSize: 15
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GoogleMap(
        markers: {
          Marker(markerId:MarkerId("1"),position: LatLng(35.84833211436672, 50.91064713388881),
          infoWindow: InfoWindow(snippet: "شعبه کرج",title: "دیجی کالا")), 
          Marker(markerId:MarkerId("2"),position: LatLng(36.285121630165385, 50.00146324270263),
          infoWindow: InfoWindow(snippet: "شعبه قزوین",title: "دیجی کالا")),
          Marker(markerId: MarkerId("3"),position: LatLng(35.68786343615628, 51.35776674677362),
          infoWindow: InfoWindow(snippet: "شعبه تهران",title: "دیجی کالا")) 
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(35.68786343615628, 53),
          zoom: 5,
          // bearing: 100,
          // tilt: 
          ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
