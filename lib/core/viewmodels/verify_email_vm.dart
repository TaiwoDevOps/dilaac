import 'package:dilaac/models/auth_models.dart';
import 'package:dilaac/network_layer/api/auth_api.dart';
import 'package:dilaac/presentation/journeys/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dilaac/common/errors/failure.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/utils/navigator.dart';

import 'loader_vm.dart';

class VerifyEmailOtpViewModel extends ChangeNotifier {
  final verifyEmailOtp = Auth();

  final TextEditingController emailTEC = TextEditingController();

  bool showBottom = false;
  VerifyOtpModel? _verifyOtpModel;
  VerifyOtpModel? get verifyOtpModel => _verifyOtpModel;

  set verifyOtpModel(VerifyOtpModel? val) {
    _verifyOtpModel = val;
    notifyListeners();
  }

  LoaderVM get loader => navigator.context!.read(loaderVM);

  void verifyEmailOtpMethod(String code) async {
    loader.isLoading = true;

    var verifyEmailOtpREQ =
        await verifyEmailOtp.verifyOtpEmail(email: emailTEC.text, code: code);

    verifyEmailOtpREQ.fold((l) => _handleError(l), (r) async {
      verifyOtpModel = r;

      notifyListeners();
      navigator.context!.navigateReplace(LoginPage());
    });

    loader.isLoading = false;
  }

  void resendEmailOtpMethod() async {
    loader.isLoading = true;

    var resendEmailOtpREQ =
        await verifyEmailOtp.resendOtpEmail(email: emailTEC.text);

    resendEmailOtpREQ.fold((l) => _handleError(l), (r) async {
      verifyOtpModel = r;

      notifyListeners();
    });

    loader.isLoading = false;
  }

  _handleError(dynamic error) async {
    var errorString = ((error is Failure) ? error.message : '$error');
    if (errorString.contains("resend")) {
      showBottom = true;
      notifyListeners();
    }
    if (errorString.contains("hasExpired")) {
      errorString = "Invalid OTP entered.\nPlease check number and try again.";
    }
    await Fluttertoast.showToast(
        msg: errorString,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
