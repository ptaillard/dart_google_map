library LocationSelect;

import 'dart:html';
import '../location/LocationInfo.dart';
import '../RouteGenerator.dart';

class LocationSelect {
  
  RouteGenerator routeGenerator;
  SelectElement select;
  
  LocationSelect(this.routeGenerator) {
    this.select = querySelector("#startcity");
  }
  
  void computeRoute(locationFirst, locationLast) {
    _appendTotalRoute(locationFirst, locationLast);
    select.onChange.listen((e) => _updateRoute());
    _updateRoute();
  }

  void appendSelectionRouteFromTo(LocationInfo cityFrom, LocationInfo cityTo) {
    _createSelectOptionRoute(cityFrom, cityTo, cityFrom.getName() + ' -> '+ cityTo.getName(), 0);
  }
  
  void _appendTotalRoute(LocationInfo cityFrom, LocationInfo cityTo) {
    _createSelectOptionRoute(cityFrom, cityTo, 'Tout', 1);
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