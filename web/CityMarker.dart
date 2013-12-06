library CityMarker;

import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'City.dart';

class CityMarker {
  GMap map;

  CityMarker(this.map);
  
  void appendOn(City city) {
    MarkerOptions option = new MarkerOptions()
        ..position = city.getCoordinate()
        ..map = map
        ..title = city.getName()
        ..zIndex = 1000;
    
    Marker marker = new Marker(option);
    
    var content = new DivElement();
    var cityText = '<span class="colorCity"><b>' + city.getName() + '</b></span><p>le ' + city.getDate().toString() + '</p>'; 
    content.innerHtml = cityText;
    
    var infoWindow = new InfoWindow(
        new InfoWindowOptions()
        ..content = content
    );
    
    marker.onClick.listen((e) {
      infoWindow.open(map, marker);
    });
  }

}