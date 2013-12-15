library LocationMarker;

import "package:intl/intl.dart";
import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'LocationInfo.dart';

class LocationMarker {
  GMap map;

  LocationMarker(this.map);
  
  void appendOn(LocationInfo location) {
    /*MarkerShape markerShape = new MarkerShape();
    markerShape.coords = l;
    markerShape.type = MarkerShapeType.POLY;*/
    
    
    MarkerOptions option = new MarkerOptions()
        ..position = location.getCoordinate()
        ..map = map
        ..title = location.getName()
        //..zIndex = 1000
        ..icon = location.iconMarker;
    
    Marker marker = new Marker(option);
    
    var content = new DivElement();
    var cityText = '<span class="colorCity"><b>' + location.getName() + '</b></span><p>le ' + new DateFormat.yMMMMd("fr_FR").format(location.getDate()) + '</p>'; 
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