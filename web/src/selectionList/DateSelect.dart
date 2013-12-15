library DateSelect;

import 'dart:html';
import '../location/LocationInfo.dart';
import '../RouteGenerator.dart';
import "package:intl/intl.dart";

class DateSelect {
  
  RouteGenerator routeGenerator;
  SelectElement select;
  
  DateSelect(this.routeGenerator) {
    this.select = querySelector("#startdate");
  }
  
  void computeRoute(locationFirst, locationLast) {
    select.onChange.listen((e) => _updateRoute());
    _updateRoute();
  }

  void appendSelectionRouteFromTo(LocationInfo cityFrom, LocationInfo cityTo) {
    _createSelectOptionRoute(cityFrom, cityTo, new DateFormat.yMMMMd("fr_FR").format(cityFrom.getDate()).toString() + 
          ' -> '+ new DateFormat.yMMMMd("fr_FR").format(cityTo.getDate()).toString(), 0);
  }

  void _createSelectOptionRoute(LocationInfo cityFrom, LocationInfo cityTo, String label, int total) {
    select.appendHtml('<option value="" data-from="' +  
        cityFrom.hashCode.toString() + '" data-to="' +  
        cityTo.hashCode.toString() + '" data-total="' + total.toString() + '">' + label + '</option>');
  }

  void _updateRoute() {
    final el = select.selectedOptions[0];
    
    final fromKey = int.parse(el.attributes['data-from']);
    final toKey = int.parse(el.attributes['data-to']);
    final total = int.parse(el.attributes['data-total']);
    
    routeGenerator.generateRoute(fromKey, toKey, total);
  }
}