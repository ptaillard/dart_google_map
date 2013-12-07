library RouteGenerator;

import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'LocationInfo.dart';
import 'City.dart';
import 'TravelManager.dart';

class RouteGenerator {
  TravelManager manager;
  SelectElement select;
  Element infos;
  
  DirectionsService directionsService;
  DirectionsRenderer directionsDisplay;
  
  RouteGenerator(TravelManager manager, map){
    this.manager = manager;
    this.infos = querySelector("#infos");
    this.directionsService = new DirectionsService();
    this.directionsDisplay = new DirectionsRenderer();  
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
}