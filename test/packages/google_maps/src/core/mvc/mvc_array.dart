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

class MVCArray<E> extends MVCObject {
  static MVCArray cast(js.Proxy proxy, [jsw.Translator translator]) => proxy == null ? null : new MVCArray.fromProxy(proxy, translator);
  static MVCArray castListOfSerializables(js.Proxy proxy, jsw.Mapper<dynamic, js.Serializable> fromJs, {mapOnlyNotNull: false}) => proxy == null ? null : new MVCArray.fromProxy(proxy, new jsw.TranslatorForSerializable(fromJs, mapOnlyNotNull: mapOnlyNotNull));
  static bool isInstance(js.Proxy proxy) => js.instanceof(proxy, maps.MVCArray);

  final jsw.Translator<E> _translator;

  SubscribeStreamProvider<int> _onInsertAt;
  SubscribeStreamProvider<IndexAndElement<E>> _onRemoveAt;
  SubscribeStreamProvider<IndexAndElement<E>> _onSetAt;

  MVCArray([List<E> array, jsw.Translator<E> translator]) : super(maps.MVCArray, [jsifyList(array)]), this._translator = translator { _initStreams(); }
  MVCArray.fromProxy(js.Proxy proxy, [jsw.Translator<E> translator]) : super.fromProxy(proxy), this._translator = translator { _initStreams(); }

  void _initStreams() {
    _onInsertAt = event.getStreamProviderFor(this, "insert_at");
    _onRemoveAt = event.getStreamProviderFor(this, "remove_at", (int index, oldElement) => new IndexAndElement<E>(index, _fromJs(oldElement)));
    _onSetAt = event.getStreamProviderFor(this, "set_at", (int index, oldElement) => new IndexAndElement<E>(index, _fromJs(oldElement)));
  }

  Stream<int> get onInsertAt => _onInsertAt.stream;
  Stream<IndexAndElement<E>> get onRemoveAt => _onRemoveAt.stream;
  Stream<IndexAndElement<E>> get onSetAt => _onSetAt.stream;

  dynamic _toJs(E e) => _translator == null ? e : _translator.toJs(e);
  E _fromJs(dynamic value) => _translator == null ? value : _translator.fromJs(value);

  void clear() { $unsafe.clear(); }
  void forEach(void callback(E o, num index)) {
    $unsafe.forEach((Object o, num index) => callback(_fromJs(o), index));
  }
  List<E> getArray() => jsw.JsArrayToListAdapter.cast($unsafe.getArray(), _translator);
  E getAt(num i) => _fromJs($unsafe.getAt(i));
  num get length => $unsafe.getLength();
  void insertAt(num i, E elem) { $unsafe.insertAt(i, _toJs(elem)); }
  E pop() => _fromJs($unsafe.pop());
  num push(E elem) => $unsafe.push(_toJs(elem));
  E removeAt(num i) => _fromJs($unsafe.removeAt(i));
  void setAt(num i, E elem) { $unsafe.setAt(i, _toJs(elem)); }

  /// deprecated : use onXxx stream.
  @deprecated MVCArrayEvents<E> get on => new MVCArrayEvents<E>._(this);
}

class IndexAndElement<E> {
  final int index;
  final E element;
  IndexAndElement(this.index, this.element);
}

@deprecated
class MVCArrayEvents<E> {
  static final INSERT_AT = "insert_at";
  static final REMOVE_AT = "remove_at";
  static final SET_AT = "set_at";

  final MVCArray<E> _mvcArray;

  MVCArrayEvents._(this._mvcArray);

  NumEventListenerAdder get insertAt => new NumEventListenerAdder(_mvcArray, INSERT_AT);
  NumAndElementEventListenerAdder<E> get removeAt => new NumAndElementEventListenerAdder<E>(_mvcArray, REMOVE_AT, _mvcArray._fromJs);
  NumAndElementEventListenerAdder<E> get setAt => new NumAndElementEventListenerAdder<E>(_mvcArray, SET_AT, _mvcArray._fromJs);
}