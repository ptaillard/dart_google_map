library RouteGenerator;

import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'location/LocationInfo.dart';
import 'location/City.dart';
import 'TravelManager.dart';

class RouteGenerator {
  TravelManager manager;
  SelectElement select;
  Element infos;
  Element distanceInfos;
  
  DirectionsService directionsService;
  DirectionsRenderer directionsDisplay;
  DistanceMatrixService distanceMatrixService;
  
  RouteGenerator(TravelManager manager, map){
    this.manager = manager;
    this.infos = querySelector("#infos");
    this.distanceInfos = querySelector("#distanceInfos");
    this.directionsService = new DirectionsService();
    this.directionsDisplay = new DirectionsRenderer();
    this.distanceMatrixService = new DistanceMatrixService();
    this.directionsDisplay.map = map;
  }
  
  void generateRoute(fromKey, toKey, total) {
    LocationInfo from = manager.getLocation(fromKey);
    LocationInfo to = manager.getLocation(toKey);
    List<DirectionsWaypoint> wayPoints = _getWayPoints(from, to, total); 
    
       DirectionsRequest directionsRequest = new DirectionsRequest()
      ..origin = from.getCoordinate()
      ..destination = to.getCoordinate()
      ..waypoints = wayPoints
      ..travelMode = TravelMode.DRIVING;
    
    directionsService.route(directionsRequest, _displayRoute);
    calculateDistances(from, to, total);
  }
  
  List<DirectionsWaypoint> _getWayPoints(LocationInfo fromKey, LocationInfo toKey, int total) {
    List<DirectionsWaypoint> list = new List<DirectionsWaypoint>();
    Iterable keys = manager.locationInfos.keys;
    bool addWayPoint = false;
    for (int number in manager.locationInfos.keys) {
      if(number == toKey.hashCode) {
        addWayPoint = false;
      }
      
      if(addWayPoint && list.length < 8) {
        if(!(total == 1 && (manager.locationInfos[number] is City) == false)) {
          list.add(new DirectionsWaypoint()..location = manager.locationInfos[number].getCoordinate());  
        }
      }
     
      if(number == fromKey.hashCode) {
        addWayPoint = true;
      }
    }
    return list;
  }
  
  
  void _displayRoute(DirectionsResult results, DirectionsStatus status) {
    if(status == DirectionsStatus.OK) {
      directionsDisplay.directions = results;
    }
    infos..text = status.value;
  }
  
  void calculateDistances(LocationInfo fromKey, LocationInfo toKey, int total) {
    distanceInfos..innerHtml = "";
    if(total != 1) {
      distanceMatrixService.getDistanceMatrix((new DistanceMatrixRequest()
      ..origins = [fromKey.getCoordinate()]
      ..destinations = [toKey.getCoordinate()]
      ..travelMode = TravelMode.DRIVING
      ..unitSystem = UnitSystem.METRIC
      ..avoidHighways = false
      ..avoidTolls = false
      ), callback);
    }
  }
  
  void callback(DistanceMatrixResponse response, DistanceMatrixStatus status) {
    if (status != DistanceMatrixStatus.OK) {
      window.alert('Error was: ${status}');
    } else {
      final origins = response.originAddresses;
      final destinations = response.destinationAddresses;
  
      final html = new StringBuffer();
      for (var i = 0; i < origins.length; i++) {
        var results = response.rows[i].elements;
        for (var j = 0; j < results.length; j++) {
          if(results[j].distance != null) {
            //html.write('Départ: ${origins[i]}<br>Arrivée: ${destinations[j]}<br>Distance à parcourir: <b>${results[j].distance.text}</b><br>Durée: <b>${results[j].duration.text}</b>');
            html.write('Distance à parcourir: <b>${results[j].distance.text}</b><br>Durée: <b>${results[j].duration.text}</b>');
          }
        }
      }
      distanceInfos..innerHtml = html.toString();
    }
  }
}