import 'dart:async';
@TestOn('vm')

//import 'package:RAL/html_i.dart';// if (dart.library.html) 'package:untitled/src/html_proxy.dart';
import 'dart:html' if (dart.library.io) 'package:RAL/html_i.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:untitled/src/ral_container.dart';

class ElementStreamMock extends Stream<MouseEvent> implements ElementStream<MouseEvent>{
  final StreamController<MouseEvent> _controller;

  /// Creates new [StreamEmitter].
  ///
  /// @param sync Fire events directly to the stream's subscriptions during an [add] call.
  /// @param broadcast Allow stream to be listened to more than once.
  ElementStreamMock({bool sync: false, bool broadcast: true}) :
        _controller = broadcast ? new StreamController.broadcast(sync: sync) : new StreamController(sync: sync);

  @override
  StreamSubscription<MouseEvent> listen(void onData(MouseEvent event), {Function onError, void onDone(), bool cancelOnError}) {
    return _controller.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void add(MouseEvent event) {
    _controller.add(event);
  }

  @override
  StreamSubscription<MouseEvent> capture(void Function(MouseEvent event) onData) {
    // TODO: implement capture
    return null;
  }

  @override
  Stream<MouseEvent> matches(String selector) {
    // TODO: implement matches
    return null;
  }
}

class ElementMock extends Mock implements Element {

  ElementMock(){
    when(onClick).thenAnswer((_)=> ElementStreamMock(sync: true));
  }
}

class MouseEventMock extends Mock implements MouseEvent {}

void main() {
  test('test ral', () {
    final el = ElementMock();
    final emitter = ElementStreamMock(sync: true);
    when(el.onClick).thenAnswer((_)=> emitter);

    final cont = RalContainer(el);
    emitter.add(MouseEventMock());
    emitter.add(MouseEventMock());
    expect(cont.element, el);
  });

  // Testing info: https://webdev.dartlang.org/angular/guide/testing
}
