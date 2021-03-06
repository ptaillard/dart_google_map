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

part of google_maps;

typedef String GetTileUrl(Point point, num zoomLevel);

class ImageMapTypeOptions extends jsw.TypedProxy {
  static ImageMapTypeOptions cast(js.Proxy proxy) => proxy == null ? null : new ImageMapTypeOptions.fromProxy(proxy);

  ImageMapTypeOptions() : super();
  ImageMapTypeOptions.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  String get alt => $unsafe['alt'];
  GetTileUrl get getTileUrl => (Point point, num zoomLevel) => $unsafe.getTileUrl(point, zoomLevel);
  num get maxZoom => $unsafe['maxZoom'];
  num get minZoom => $unsafe['minZoom'];
  String get name => $unsafe['name'];
  num get opacity => $unsafe['opacity'];
  Size get tileSize => Size.cast($unsafe['tileSize']);
  set alt(String alt) => $unsafe['alt'] = alt;
  // REPORTED report wtf arg : http://code.google.com/p/gmaps-api-issues/issues/detail?id=4573
  set getTileUrl(GetTileUrl callback) => $unsafe['getTileUrl'] = (js.Proxy point, num zoomLevel, [dynamic wtf]) => callback(Point.cast(point), zoomLevel);
  set maxZoom(num maxZoom) => $unsafe['maxZoom'] = maxZoom;
  set minZoom(num minZoom) => $unsafe['minZoom'] = minZoom;
  set name(String name) => $unsafe['name'] = name;
  set opacity(num opacity) => $unsafe['opacity'] = opacity;
  set tileSize(Size tileSize) => $unsafe['tileSize'] = tileSize;
}