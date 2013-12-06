library TravelManager;

import 'dart:html';
import 'dart:collection';
import 'package:google_maps/google_maps.dart';
import 'City.dart';
import 'CityMarker.dart';

class TravelManager {
  GMap map;
  CityMarker marker;
  LinkedHashMap<int, City> cities;  
  DirectionsService directionsService;
  DirectionsRenderer directionsDisplay;
  
  TravelManager(this.map){
    this.directionsService = new DirectionsService();
    this.directionsDisplay = new DirectionsRenderer();  
    this.directionsDisplay.map = this.map;

    this.cities = new LinkedHashMap();
    this.marker = new CityMarker(this.map);
  }
  
  void appendArrivalCity(City city) {
    if(cities.isNotEmpty) {
      City previousCity = cities[cities.keys.last];
      _addOptionStartCity(previousCity, city);
    }
    cities[city.hashCode] = city;
    marker.appendOn(city);
  }
  
  void computeRoute() {
    _addAllCity(cities[cities.keys.first], cities[cities.keys.last]);
    querySelector('#startcity').onChange.listen((e) => _updateRoute());
    _updateRoute();
  }

  City _getCity(int hashcode) {
    return cities[hashcode];
  }

  void _addAllCity(City cityFrom, City cityTo) {
    _appendNewRoute(cityFrom, cityTo, 'Tout');
  }
  
  void _addOptionStartCity(City cityFrom, City cityTo) {
    _appendNewRoute(cityFrom, cityTo, cityFrom.getName() + ' -> '+ cityTo.getName());
  }

  void _appendNewRoute(City cityFrom, City cityTo, String label) {
    querySelector("#startcity").appendHtml('<option value="" data-from="' +  
        cityFrom.hashCode.toString() + '" data-to="' +  
        cityTo.hashCode.toString() + '">' + label + '</option>');
  }

  void _updateRoute() {
    final element = querySelector('#startcity') as SelectElement;
    final el = element.selectedOptions[0];
    
    final fromCityKey = int.parse(el.attributes['data-from']);
    final toCityKey = int.parse(el.attributes['data-to']);
    
    City fromCity = _getCity(fromCityKey);
    City toCity = _getCity(toCityKey);
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
    Iterable keys = cities.keys;
    bool addWayPoint = false;
    for (int number in cities.keys) {
      if(number == toCityKey) {
        addWayPoint = false;
      }
      
      if(addWayPoint) {
        list.add(new DirectionsWaypoint()..location = cities[number].getCoordinate());
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
    querySelector("#infos")..text = status.value;
  }
  

}