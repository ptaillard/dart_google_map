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

class GroundOverlay extends MVCObject {
  static GroundOverlay cast(js.Proxy proxy) => proxy == null ? null : new GroundOverlay.fromProxy(proxy);

  SubscribeStreamProvider<MouseEvent> _onClick;
  SubscribeStreamProvider<MouseEvent> _onDblClick;

  GroundOverlay(String url, LatLngBounds bounds, [GroundOverlayOptions opts]) : super(maps.GroundOverlay, [url, bounds, opts]) { _initStreams(); }
  GroundOverlay.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) { _initStreams(); }

  void _initStreams() {
    _onClick = event.getStreamProviderFor(this, "click", MouseEvent.cast);
    _onDblClick = event.getStreamProviderFor(this, "dblclick", MouseEvent.cast);
  }

  Stream<MouseEvent> get onClick => _onClick.stream;
  Stream<MouseEvent> get onDblClick => _onDblClick.stream;

  LatLngBounds get bounds => LatLngBounds.cast($unsafe.getBounds());
  GMap get map => GMap.cast($unsafe.getMap());
  num get opacity => $unsafe.getOpacity();
  String get url => $unsafe.getUrl();
  set map(GMap map) => $unsafe.setMap(map);
  set opacity(num opacity) => $unsafe.setOpacity(opacity);

  /// deprecated : use onXxx stream.
  @deprecated GroundOverlayEvents get on => new GroundOverlayEvents._(this);
}

@deprecated
class GroundOverlayEvents {
  static final CLICK = "click";
  static final DBLCLICK = "dblclick";

  final GroundOverlay _groundOverlay;

  GroundOverlayEvents._(this._groundOverlay);

  MouseEventListenerAdder get click => new MouseEventListenerAdder(_groundOverlay, CLICK);
  MouseEventListenerAdder get dblclick => new MouseEventListenerAdder(_groundOverlay, DBLCLICK);
}