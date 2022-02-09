import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

String roundDouble(double sendVal, dynamic receiveVal) {
  return ((sendVal * receiveVal).toStringAsFixed(1));
}

void share(String url) async {
  await Share.share(
    "Dilaac payment link $url",
  );
}

class CopyKeys {
  static final paymentLink = GlobalKey(debugLabel: "payment_link");
}
