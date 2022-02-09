import 'package:flutter/material.dart';

class LoaderVM extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double? _percent;
  double? get percent => _percent;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set percent(double? val) {
    _percent = val;
    notifyListeners();
  }
}
