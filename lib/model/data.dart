import 'package:flutter/foundation.dart';

class Data extends ChangeNotifier {
  int? _number;

  int? get number => _number;

  setNumber(int number) {
    _number = number;
    notifyListeners();
  }
}
