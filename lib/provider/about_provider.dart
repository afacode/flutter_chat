import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AboutProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _count  = 0;
  int get count => _count;

  void add() {
    _count += 1;
    notifyListeners();
  }

  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }

}