import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/presentation/journeys/fab_widget.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Controller extends StatefulHookWidget {
  Controller({required this.loginModel});

  final dynamic loginModel;
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  String? rateResultProvider;
  var formKey = GlobalKey<FormState>();

  final _sendHowMuchCAD = TextEditingController();

  var sendVal, rateVal;
  @override
  void initState() {
    super.initState();

    context.read(controllerVM).loginModel = widget.loginModel;
  }

  @override
  Widget build(BuildContext context) {
    var currentScreen =
        useProvider(controllerVM.select((_) => _.currentScreen));

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            currentScreen,
          ],
        ),
      ),
    );
  }
}
