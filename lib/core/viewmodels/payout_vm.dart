import 'package:flutter/material.dart';

class PayoutVm extends ChangeNotifier {
  final TextEditingController acctNameTEC = TextEditingController();
  final TextEditingController acctNumberTEC = TextEditingController();
  final TextEditingController bankNameTEC = TextEditingController();
  final TextEditingController amountTEC = TextEditingController();
  final TextEditingController descTEC = TextEditingController();
  final TextEditingController pin1TEC = TextEditingController();
  final TextEditingController pin2TEC = TextEditingController();
}
