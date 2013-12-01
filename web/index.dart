// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library google_maps;

// This code is derived from
// https://developers.google.com/maps/documentation/javascript/tutorial#HelloWorld
// You can view the original JavaScript example at
// https://developers.google.com/maps/documentation/javascript/examples/map-simple
/*
import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:google_maps/google_maps.dart';

DirectionsRenderer directionsDisplay;
final DirectionsService directionsService = new DirectionsService();
GMap map;

void main() {
  directionsDisplay = new DirectionsRenderer();
  final chicago = new LatLng(41.850033, -87.6500523);
  final mapOptions = new MapOptions()
    ..zoom = 7
    ..mapTypeId = MapTypeId.ROADMAP
    ..center = chicago
    ;
  map = new GMap(querySelector("#map-canvas"), mapOptions);
  directionsDisplay.map = map;

  calcRoute();
}

void calcRoute() {
  final start = "chicago, il";
  final end = "st louis, mo";
  final request = new DirectionsRequest()
    ..origin = new LatLng(37.781298,-122.418648)
    ..destination = new LatLng(34.911273,-117.015488) 
    ..travelMode = TravelMode.DRIVING // TODO bad object in example DirectionsTravelMode
    ;
  directionsService.route(request, (DirectionsResult response, DirectionsStatus status) {
    if (status == DirectionsStatus.OK) {
      directionsDisplay.directions = response;
    }
  });
}*/

import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:google_maps/google_maps.dart';

final DirectionsService directionsService = new DirectionsService();
DirectionsRenderer directionsDisplay;
GMap map;

void main() {
  initGoogleMap();
 
  createMarkerCity();
 
  querySelector("#startcity").appendHtml('<option value="0" data-latstart="37.781298" data-lngstart="-122.418648" data-latend="37.000668" data-lngend="-110.173627">Tout</option>');
  querySelector("#startcity").appendHtml('<option value="0" data-latstart="37.781298" data-lngstart="-122.418648" data-latend="34.911273" data-lngend="-117.015488">San Francisco</option>');
  querySelector("#startcity").appendHtml('<option value="1" data-latstart="34.911273" data-lngstart="-117.015488" data-latend="35.202428" data-lngend="-114.055359">Barstow</option>');
  querySelector("#startcity").appendHtml('<option value="2" data-latstart="35.202428" data-lngstart="-114.055359" data-latend="36.061034" data-lngend="-112.142311">Kingman</option>');
  querySelector("#startcity").appendHtml('<option value="3" data-latstart="36.061034" data-lngstart="-112.142311" data-latend="37.000668" data-lngend="-110.173627">Grand Canyon</option>');
  
  querySelector('#startcity').onChange.listen((e) => computeRoute());
  
  computeRoute();
}

void createMarkerCity() {
   LatLng coordinate = new LatLng(37.781298,-122.418648); 
  addMarkerOnCity(map, coordinate, 'San Francisco', '16 Juin');
  
  LatLng coordinateBarstow = new LatLng(34.911273,-117.015488); 
  addMarkerOnCity(map, coordinateBarstow, 'Barstow', '20 Juin');
  
  LatLng coordinateKingman = new LatLng(35.202428,-114.055359); 
  addMarkerOnCity(map, coordinateKingman, 'Kingman', '21 Juin');
  
  LatLng coordinateGrandCanyon = new LatLng(36.061034,-112.142311); 
  addMarkerOnCity(map, coordinateGrandCanyon, 'Grand Canyon', '22 Juin');
  
  LatLng coordinateMonumentValley = new LatLng(37.000668,-110.173627); 
  addMarkerOnCity(map, coordinateMonumentValley, 'Monument Valley', '26 Juin');
  
  
}

void initGoogleMap() {
  directionsDisplay = new DirectionsRenderer();
  final SanFrancisco = new LatLng(37.781298,-122.418648);
  final mapOptions = new MapOptions()
    ..zoom = 7
    ..mapTypeId = MapTypeId.ROADMAP
    ..center = SanFrancisco
    ;
  map = new GMap(querySelector("#map-canvas"), mapOptions);
  directionsDisplay.map = map;
}

void computeRoute() {
  final element1 = querySelector('#startcity') as SelectElement;
  final el = element1.selectedOptions[0];
  
  final lats = double.parse(el.attributes['data-latstart']);
  final lngs = double.parse(el.attributes['data-lngstart']);
  final late = double.parse(el.attributes['data-latend']);
  final lnge = double.parse(el.attributes['data-lngend']);
  
 DirectionsRequest directionsRequest = new DirectionsRequest()
    ..origin = new LatLng(lats, lngs)
    ..destination = new LatLng(late, lnge)
    ..travelMode = TravelMode.DRIVING;
  
  directionsService.route(directionsRequest, displayRoute);
}

void addMarkerOnCity(map, coordinate, city, date) {
   var marker = new Marker(
      new MarkerOptions()
      ..position = coordinate
      ..map = map
      ..title = city
  );
  
  var content = new DivElement();
  var cityText = '<span class="colorCity"><b>' + city + '</b></span><p>le ' + date + '</p>'; 
  content.innerHtml = cityText;
  
  var infoWindow = new InfoWindow(
    new InfoWindowOptions()
      ..content = content
  );
  
  marker.onClick.listen((e) {
    infoWindow.open(map, marker);
  });
}


void displayRoute(DirectionsResult results, DirectionsStatus status) {
  if(status == DirectionsStatus.OK) {
    directionsDisplay.directions = results;
  }
  querySelector("#infos")..text = status.value;
}
