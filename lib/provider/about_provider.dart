import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AboutProvider with ChangeNotifier {
  int _count  =10;
  int get count => _count;

  void add() {
    _count += 1;
    notifyListeners();
  }
}