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

class Rectangle extends MVCObject {
  static Rectangle cast(js.Proxy proxy) => proxy == null ? null : new Rectangle.fromProxy(proxy);
  static bool isInstance(js.Proxy proxy) => js.instanceof(proxy, maps.Rectangle);

  SubscribeStreamProvider _onBoundsChanged;
  SubscribeStreamProvider<MouseEvent> _onClick;
  SubscribeStreamProvider<MouseEvent> _onDblClick;
  SubscribeStreamProvider<MouseEvent> _onMousedown;
  SubscribeStreamProvider<MouseEvent> _onMousemove;
  SubscribeStreamProvider<MouseEvent> _onMouseout;
  SubscribeStreamProvider<MouseEvent> _onMouseover;
  SubscribeStreamProvider<MouseEvent> _onMouseup;
  SubscribeStreamProvider<MouseEvent> _onRightclick;

  Rectangle([RectangleOptions opts]) : super(maps.Rectangle, [opts]) { _initStreams(); }
  Rectangle.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) { _initStreams(); }

  void _initStreams() {
    _onBoundsChanged = event.getStreamProviderFor(this, "bounds_changed");
    _onClick = event.getStreamProviderFor(this, "click", MouseEvent.cast);
    _onDblClick = event.getStreamProviderFor(this, "dblclick", MouseEvent.cast);
    _onMousedown = event.getStreamProviderFor(this, "mousedown", MouseEvent.cast);
    _onMousemove = event.getStreamProviderFor(this, "mousemove", MouseEvent.cast);
    _onMouseout = event.getStreamProviderFor(this, "mouseout", MouseEvent.cast);
    _onMouseover = event.getStreamProviderFor(this, "mouseover", MouseEvent.cast);
    _onMouseup = event.getStreamProviderFor(this, "mouseup", MouseEvent.cast);
    _onRightclick = event.getStreamProviderFor(this, "rightclick", MouseEvent.cast);
  }

  Stream get onBoundsChanged => _onBoundsChanged.stream;
  Stream<MouseEvent> get onClick => _onClick.stream;
  Stream<MouseEvent> get onDblClick => _onDblClick.stream;
  Stream<MouseEvent> get onMousedown => _onMousedown.stream;
  Stream<MouseEvent> get onMousemove => _onMousemove.stream;
  Stream<MouseEvent> get onMouseout => _onMouseout.stream;
  Stream<MouseEvent> get onMouseover => _onMouseover.stream;
  Stream<MouseEvent> get onMouseup => _onMouseup.stream;
  Stream<MouseEvent> get onRightclick => _onRightclick.stream;

  LatLngBounds get bounds => LatLngBounds.cast($unsafe.getBounds());
  bool get draggable => $unsafe.getDraggable();
  bool get editable => $unsafe.getEditable();
  GMap get map => GMap.cast($unsafe.getMap());
  bool get visible => $unsafe.getVisible();
  set bounds(LatLngBounds bounds) => $unsafe.setBounds(bounds);
  set draggable(bool draggable) => $unsafe.setDraggable(draggable);
  set editable(bool editable) => $unsafe.setEditable(editable);
  set map(GMap map) => $unsafe.setMap(map);
  set options(RectangleOptions options) => $unsafe.setOptions(options);
  set visible(bool visible) => $unsafe.setVisible(visible);

  /// deprecated : use onXxx stream.
  @deprecated RectangleEvents get on => new RectangleEvents._(this);
}

@deprecated
class RectangleEvents {
  static final BOUNDS_CHANGED = "bounds_changed";
  static final CLICK = "click";
  static final DBLCLICK = "dblclick";
  static final MOUSEDOWN = "mousedown";
  static final MOUSEMOVE = "mousemove";
  static final MOUSEOUT = "mouseout";
  static final MOUSEOVER = "mouseover";
  static final MOUSEUP = "mouseup";
  static final RIGHTCLICK = "rightclick";

  final Rectangle _rectangle;

  RectangleEvents._(this._rectangle);

  NoArgsEventListenerAdder get boundsChanged => new NoArgsEventListenerAdder(_rectangle, BOUNDS_CHANGED);
  MouseEventListenerAdder get click => new MouseEventListenerAdder(_rectangle, CLICK);
  MouseEventListenerAdder get dblclick => new MouseEventListenerAdder(_rectangle, DBLCLICK);
  MouseEventListenerAdder get mousedown => new MouseEventListenerAdder(_rectangle, MOUSEDOWN);
  MouseEventListenerAdder get mousemove => new MouseEventListenerAdder(_rectangle, MOUSEMOVE);
  MouseEventListenerAdder get mouseout => new MouseEventListenerAdder(_rectangle, MOUSEOUT);
  MouseEventListenerAdder get mouseover => new MouseEventListenerAdder(_rectangle, MOUSEOVER);
  MouseEventListenerAdder get mouseup => new MouseEventListenerAdder(_rectangle, MOUSEUP);
  MouseEventListenerAdder get rightclick => new MouseEventListenerAdder(_rectangle, RIGHTCLICK);
}