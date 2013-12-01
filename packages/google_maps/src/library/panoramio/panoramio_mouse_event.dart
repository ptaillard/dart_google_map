// Copyright (c) 2012, Alexandre Ardhuin
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

part of google_maps_panoramio;

class PanoramioMouseEvent extends jsw.TypedProxy {
  static PanoramioMouseEvent cast(js.Proxy proxy) => proxy == null ? null : new PanoramioMouseEvent.fromProxy(proxy);

  PanoramioMouseEvent();
  PanoramioMouseEvent.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  PanoramioFeature get featureDetails => PanoramioFeature.cast($unsafe['featureDetails']);
  String get infoWindowHtml => $unsafe['infoWindowHtml'];
  LatLng get latLng => LatLng.cast($unsafe['latLng']);
  Size get pixelOffset => Size.cast($unsafe['pixelOffset']);
  set featureDetails(PanoramioFeature featureDetails) => $unsafe['featureDetails'] = featureDetails;
  set infoWindowHtml(String infoWindowHtml) => $unsafe['infoWindowHtml'] = infoWindowHtml;
  set latLng(LatLng latLng) => $unsafe['latLng'] = latLng;
  set pixelOffset(Size pixelOffset) => $unsafe['pixelOffset'] = pixelOffset;
}