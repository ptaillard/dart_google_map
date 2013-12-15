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

part of google_maps_places;

class Autocomplete extends MVCObject {
  static Autocomplete cast(js.Proxy proxy) => proxy == null ? null : new Autocomplete.fromProxy(proxy);

  SubscribeStreamProvider _onPlaceChanged;

  Autocomplete(html.InputElement inputField, [AutocompleteOptions opts]) : super(maps.places.Autocomplete, [inputField, opts]) { _initStreams(); }
  Autocomplete.fromProxy(js.Proxy proxy) : super.fromProxy(proxy) { _initStreams(); }

  void _initStreams() {
    _onPlaceChanged = event.getStreamProviderFor(this, "place_changed");
  }

  Stream get onPlaceChanged => _onPlaceChanged.stream;

  LatLngBounds get bounds => LatLngBounds.cast($unsafe.getBounds());
  PlaceResult get place => PlaceResult.cast($unsafe.getPlace());
  set bounds(LatLngBounds bounds) => $unsafe.setBounds(bounds);
  set componentRestrictions(ComponentRestrictions restrictions) => $unsafe.setComponentRestrictions(restrictions);
  set types(List<String> types) => $unsafe.setTypes(types);

  /// deprecated : use onXxx stream.
  @deprecated AutocompleteEvents get on => new AutocompleteEvents._(this);
}

@deprecated
class AutocompleteEvents {
  static final PLACE_CHANGED = "place_changed";

  final Autocomplete _autocomplete;

  AutocompleteEvents._(this._autocomplete);

  NoArgsEventListenerAdder get placeChanged => new NoArgsEventListenerAdder(_autocomplete, PLACE_CHANGED);
}