library TravelManager;

import 'dart:html';
import 'dart:collection';
import 'package:google_maps/google_maps.dart';
import 'City.dart';
import 'CityMarker.dart';
import 'CitySelect.dart';

class TravelManager {
  GMap map;
  CityMarker marker;
  CitySelect citySelect;
  LinkedHashMap<int, City> cities;
  
  TravelManager(this.map){
    this.cities = new LinkedHashMap();
    this.marker = new CityMarker(this.map);
    this.citySelect = new CitySelect(this, this.map);
  }
  
  void appendArrivalCity(City city) {
    if(cities.isNotEmpty) {
      City previousCity = cities[cities.keys.last];
      citySelect.appendSelectionRouteCityFromCityTo(previousCity, city);
    }
    cities[city.hashCode] = city;
    marker.appendOn(city);
  }
  
  void computeRoute() {
    citySelect.computeRoute(cities[cities.keys.first], cities[cities.keys.last]);
  }

  City getCity(int hashcode) {
    return cities[hashcode];
  }
}