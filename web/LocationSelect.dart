library LocationSelect;

import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'LocationInfo.dart';
import 'TravelManager.dart';

class LocationSelect {
  
  TravelManager manager;
  SelectElement select;
  Element infos;
  
  DirectionsService directionsService;
  DirectionsRenderer directionsDisplay;
  
  LocationSelect(TravelManager manager, map) {
    this.manager = manager;
    this.select = querySelector("#startcity");
    this.infos = querySelector("#infos");
    this.directionsService = new DirectionsService();
    this.directionsDisplay = new DirectionsRenderer();  
    this.directionsDisplay.map = map;
  }
  
  void computeRoute(locationFirst, locationLast) {
    _appendTotalRoute(locationFirst, locationLast);
    select.onChange.listen((e) => _updateRoute());
    _updateRoute();
  }

  void appendSelectionRouteFromTo(LocationInfo cityFrom, LocationInfo cityTo) {
    _createSelectOptionRoute(cityFrom, cityTo, cityFrom.getName() + ' -> '+ cityTo.getName());
  }
  
  void _appendTotalRoute(LocationInfo cityFrom, LocationInfo cityTo) {
    _createSelectOptionRoute(cityFrom, cityTo, 'Tout');
  }

  void _createSelectOptionRoute(LocationInfo cityFrom, LocationInfo cityTo, String label) {
    select.appendHtml('<option value="" data-from="' +  
        cityFrom.hashCode.toString() + '" data-to="' +  
        cityTo.hashCode.toString() + '">' + label + '</option>');
  }

  void _updateRoute() {
    final el = select.selectedOptions[0];
    
    final fromKey = int.parse(el.attributes['data-from']);
    final toKey = int.parse(el.attributes['data-to']);
    
    LocationInfo from = manager.getLocation(fromKey);
    LocationInfo to = manager.getLocation(toKey);
    List<DirectionsWaypoint> wayPoints = _getWayPoints(fromKey, toKey); 
    
   DirectionsRequest directionsRequest = new DirectionsRequest()
      ..origin = from.getCoordinate()
      ..destination = to.getCoordinate()
      ..waypoints = wayPoints
      ..travelMode = TravelMode.DRIVING;
    
    directionsService.route(directionsRequest, _displayRoute);
  }
  
  List<DirectionsWaypoint> _getWayPoints(int fromKey, int toKey) {
    List<DirectionsWaypoint> list = new List<DirectionsWaypoint>();
    Iterable keys = manager.locationInfos.keys;
    bool addWayPoint = false;
    for (int number in manager.locationInfos.keys) {
      if(number == toKey) {
        addWayPoint = false;
      }
      
      if(addWayPoint && list.length < 8) {
        list.add(new DirectionsWaypoint()..location = manager.locationInfos[number].getCoordinate());
      }
     
      if(number == fromKey) {
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