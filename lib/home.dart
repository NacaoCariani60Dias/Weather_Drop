import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  bool check = false;
  var endereco;
  var latitude;
  var longitude;

  void _Check() async{
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    latitude = position.latitude;
    longitude = position.longitude;
    List<Placemark>placemark = 
      await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemark[0];
   setState(() {
     check = true;
     endereco = "${place.locality}, ${place.postalCode}, ${place.country}";
   }); 
  }

  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text("AppGPS"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            check ? Text(endereco) : Container(),
            check ? Text('Latiturde = $latitude') : Container(),
            check ? Text('Longitude = $longitude') : Container(),
            TextButton(onPressed: () {
              _Check();
            }, child: Text("Localiza ai bb", 
            style: TextStyle(fontSize: 20),))
          ],
        ),),
    );
  }
}