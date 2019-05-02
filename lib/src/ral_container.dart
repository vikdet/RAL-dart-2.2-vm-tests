//import 'package:RAL/html_i.dart' if (dart.library.html) 'package:untitled/src/html_proxy.dart';
import 'dart:html' if (dart.library.io) 'package:RAL/html_i.dart';

class RalContainer {
  final Element element;

  RalContainer(this.element) {
    element.onClick.listen(print);
  }
}
