import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:dilaac/core/providers.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';

class ControllerVM extends ChangeNotifier {
  static ControllerVM get instance => navigator.context!.read(controllerVM);

  //number of screens
  final screens = <Widget>[
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  late dynamic loginModel;

  Widget get currentScreen => screens[index];

  int _index = 0;
  int get index => _index;
  set index(int val) {
    _index = val;
    notifyListeners();
  }

  bool _showingLogout = false;
  bool get showingLogout => _showingLogout;
  set showingLogout(bool val) {
    _showingLogout = val;
    notifyListeners();
  }

  void bottomTapped(int _) {
    index = _;
  }
}
