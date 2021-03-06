// Copyright (c) 2013, Alexandre Ardhuin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of google_maps_visualization;

class DemographicsPolygonOptions extends jsw.TypedProxy {
  static DemographicsPolygonOptions cast(js.Proxy proxy) => proxy == null ? null : new DemographicsPolygonOptions.fromProxy(proxy);

  DemographicsPolygonOptions() : super();
  DemographicsPolygonOptions.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  String get fillColor => $unsafe['fillColor'];
  DemographicsPropertyStyle get fillColorStyle => DemographicsPropertyStyle.cast($unsafe['fillColorStyle']);
  num get fillOpacity => $unsafe['fillOpacity'];
  DemographicsPropertyStyle get fillOpacityStyle => DemographicsPropertyStyle.cast($unsafe['fillOpacityStyle']);
  String get strokeColor => $unsafe['strokeColor'];
  DemographicsPropertyStyle get strokeColorStyle => DemographicsPropertyStyle.cast($unsafe['strokeColorStyle']);
  num get strokeOpacity => $unsafe['strokeOpacity'];
  DemographicsPropertyStyle get strokeOpacityStyle => DemographicsPropertyStyle.cast($unsafe['strokeOpacityStyle']);
  num get strokeWeight => $unsafe['strokeWeight'];
  set fillColor(String fillColor) => $unsafe['fillColor'] = fillColor;
  set fillColorStyle(DemographicsPropertyStyle fillColorStyle) => $unsafe['fillColorStyle'] = fillColorStyle;
  set fillOpacity(num fillOpacity) => $unsafe['fillOpacity'] = fillOpacity;
  set fillOpacityStyle(DemographicsPropertyStyle fillOpacityStyle) => $unsafe['fillOpacityStyle'] = fillOpacityStyle;
  set strokeColor(String strokeColor) => $unsafe['strokeColor'] = strokeColor;
  set strokeColorStyle(DemographicsPropertyStyle strokeColorStyle) => $unsafe['strokeColorStyle'] = strokeColorStyle;
  set strokeOpacity(num strokeOpacity) => $unsafe['strokeOpacity'] = strokeOpacity;
  set strokeOpacityStyle(DemographicsPropertyStyle strokeOpacityStyle) => $unsafe['strokeOpacityStyle'] = strokeOpacityStyle;
  set strokeWeight(num strokeWeight) => $unsafe['strokeWeight'] = strokeWeight;
}