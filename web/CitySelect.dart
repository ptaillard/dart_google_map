library CitySelect;

import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'City.dart';
import 'TravelManager.dart';

class CitySelect {
  
  TravelManager manager;
  SelectElement select;
  Element infos;
  
  DirectionsService directionsService;
  DirectionsRenderer directionsDisplay;
  
  CitySelect(TravelManager manager, map) {
    this.manager = manager;
    this.select = querySelector("#startcity");
    this.infos = querySelector("#infos");
    this.directionsService = new DirectionsService();
    this.directionsDisplay = new DirectionsRenderer();  
    this.directionsDisplay.map = map;
  }
  
  void computeRoute(cityFirst, cityLast) {
    _appendTotalRoute(cityFirst, cityLast);
    select.onChange.listen((e) => _updateRoute());
    _updateRoute();
  }

  void appendSelectionRouteCityFromCityTo(City cityFrom, City cityTo) {
    _createSelectOptionRoute(cityFrom, cityTo, cityFrom.getName() + ' -> '+ cityTo.getName());
  }
  
  void _appendTotalRoute(City cityFrom, City cityTo) {
    _createSelectOptionRoute(cityFrom, cityTo, 'Tout');
  }

  void _createSelectOptionRoute(City cityFrom, City cityTo, String label) {
    select.appendHtml('<option value="" data-from="' +  
        cityFrom.hashCode.toString() + '" data-to="' +  
        cityTo.hashCode.toString() + '">' + label + '</option>');
  }

  void _updateRoute() {
    final el = select.selectedOptions[0];
    
    final fromCityKey = int.parse(el.attributes['data-from']);
    final toCityKey = int.parse(el.attributes['data-to']);
    
    City fromCity = manager.getCity(fromCityKey);
    City toCity = manager.getCity(toCityKey);
    List<DirectionsWaypoint> wayPoints = _getWayPoints(fromCityKey, toCityKey); 
    
   DirectionsRequest directionsRequest = new DirectionsRequest()
      ..origin = fromCity.getCoordinate()
      ..destination = toCity.getCoordinate()
      ..waypoints = wayPoints
      ..travelMode = TravelMode.DRIVING;
    
    directionsService.route(directionsRequest, _displayRoute);
  }
  
  List<DirectionsWaypoint> _getWayPoints(int fromCityKey, int toCityKey) {
    List<DirectionsWaypoint> list = new List<DirectionsWaypoint>();
    Iterable keys = manager.cities.keys;
    bool addWayPoint = false;
    for (int number in manager.cities.keys) {
      if(number == toCityKey) {
        addWayPoint = false;
      }
      
      if(addWayPoint && list.length < 8) {
        list.add(new DirectionsWaypoint()..location = manager.cities[number].getCoordinate());
      }
     
      if(number == fromCityKey) {
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