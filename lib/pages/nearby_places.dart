import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voyager_v01/nearby_reponse.dart';

import 'package:http/http.dart' as http;

class NearByPlacesScreen extends StatefulWidget {
  const NearByPlacesScreen({Key? key}) : super(key: key);

  @override
  State<NearByPlacesScreen> createState() => _NearByPlacesScreenState();
}

class _NearByPlacesScreenState extends State<NearByPlacesScreen> {
  String apiKey = "AIzaSyDi9LTi74Ad-hxuJC8n92hHUBD2O9ItN4U";
  String radius = "250";

  double latitude = 38.7377200;
  double longitude = 35.473196;

  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Places'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  getNearbyPlacesByType('school');
                },
                child: const Text("Get Nearby Schools")),
            ElevatedButton(
                onPressed: () {
                  getNearbyPlacesByKeyword('hukuk');
                },
                child: const Text("Get Nearby Law Offices")),
            ElevatedButton(
                onPressed: () {
                  getNearbyPlacesByKeyword('restaurant');
                },
                child: const Text("Get Nearby Restaurants")),
            ElevatedButton(
                onPressed: () {
                  getNearbyPlacesByKeyword('coffee');
                },
                child: const Text("Get Nearby Cafés")),
            ElevatedButton(
                onPressed: () {
                  getNearbyPlacesByKeyword('shopping');
                },
                child: const Text("Get Nearby Shops")),
            if (nearbyPlacesResponse.results != null)
              for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
                nearbyPlacesWidget(nearbyPlacesResponse.results![i])
          ],
        ),
      ),
    );
  }

  void getNearbyPlacesByKeyword(String input) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$input&location=$latitude,$longitude&radius=$radius&key=$apiKey');

    var response = await http.post(url);

    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    setState(() {});
  }

  void getNearbyPlacesByType(String input) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$input&key=$apiKey');

    var response = await http.post(url);

    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    setState(() {});
  }

  Widget nearbyPlacesWidget(Results results) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("Name: " + results.name!),
          Text("Location: " +
              results.geometry!.location!.lat.toString() +
              " , " +
              results.geometry!.location!.lng.toString()),
          Text(results.openingHours != null ? "Open" : "Closed"),
        ],
      ),
    );
  }
}
