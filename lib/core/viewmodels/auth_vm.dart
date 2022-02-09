import 'package:dartz/dartz.dart';
import 'package:dilaac/common/errors/failure.dart';
import 'package:dilaac/models/auth_models.dart';
import 'package:dilaac/models/user_profile.dart';
import 'package:dilaac/network_layer/api/auth_api.dart';
import 'package:dilaac/network_layer/api/get_user_profile_api.dart';
import 'package:dilaac/presentation/journeys/auth/otp_verification_screen.dart';
import 'package:dilaac/presentation/journeys/home_page/home_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/utils/local_storage.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart';
import 'loader_vm.dart';

class AuthViewModel extends ChangeNotifier {
  final auth = Auth();
  final userProfileApi = UserProfileApi();

  final TextEditingController firstNameTEC = TextEditingController();
  final TextEditingController lastNameTEC = TextEditingController();
  final TextEditingController businessNameTEC = TextEditingController();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController countryTEC = TextEditingController();
  final TextEditingController countryCodeTEC = TextEditingController();
  final TextEditingController phoneNumberTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController projectNameTEC = TextEditingController();

  late RegisterModel _signupModel;

  RegisterModel get userDataModel => _signupModel;

  set userDataModel(RegisterModel val) {
    _signupModel = val;
    notifyListeners();
  }

  LoginModel? _loginModel;
  LoginModel? get loginModel => _loginModel;

  set loginModel(LoginModel? val) {
    _loginModel = val;
    notifyListeners();
  }

  bool showBottom = false;

  LoaderVM get loader => navigator.context!.read(loaderVM);

  init() {
    emailTEC.clear();
    businessNameTEC.clear();
    countryTEC.clear();
    passwordTEC.clear();
    phoneNumberTEC.clear();
    projectNameTEC.clear();
    countryCodeTEC.clear();
  }

  /// Resgister a new user request
  void register() async {
    loader.isLoading = true;

    var registerREQ = await auth.createAccount(
      email: emailTEC.text,
      businessName: businessNameTEC.text,
      country: countryTEC.text,
      password: passwordTEC.text,
      phoneNumber: phoneNumberTEC.text,
      countryCode: countryCodeTEC.text,
      firstName: firstNameTEC.text,
      lastName: lastNameTEC.text,
      projectName: projectNameTEC.text,
    );

    registerREQ.fold((l) => _handleError(l), (r) async {
      userDataModel = r;
      navigator.context!.read(verifyEmailOtpVM)..emailTEC.text = emailTEC.text;
      notifyListeners();

      businessNameTEC.text = '';
      projectNameTEC.text = '';
      phoneNumberTEC.text = '';
      emailTEC.text = '';
      passwordTEC.text = '';
      showBottom = true;
      notifyListeners();

      navigator.context!.navigateReplace(OtpVerificationScreen());
    });

    loader.isLoading = false;
  }

  //Login Request
  Future login() async {
    loader.isLoading = true;

    var loginREQ = await auth.login(
      email: emailTEC.text,
      password: passwordTEC.text,
    );

    await _handelUserLogin(
      loginREQ,
      email: emailTEC.text,
      pass: passwordTEC.text,
    );

    loader.isLoading = false;
  }

  Future _handelUserLogin(
    Either<Failure, LoginModel> loginREQ, {
    String? email,
    String? pass,
  }) async {
    return loginREQ.fold((l) => _handleError(l), (r) async {
      navigator.context!.read(userProfileVM)..userProfileModel = null;
      navigator.context!.read(transHistoryVM)..transHistoryModel = null;
      await LocalStorage.eraseItem(key: SharedPrefKeys.LOGIN_MODEL);
      await LocalStorage.saveLoginData(token: r.token!.token!);
      await navigator.context!.read(userProfileVM).init();
      await navigator.context!.read(transHistoryVM).init();
      await navigator.context!.read(paymentLinkVM).init();

      var getProfileREQ =
          await userProfileApi.getUserProfile(token: r.token!.token!);
      await _handelUserProfile(getProfileREQ);
      loginModel = r;
    });
  }

  Future _handelUserProfile(Either<Failure, UserProfileModel> loginREQ) async {
    return loginREQ.fold((l) => _handleError(l), (r) async {
      navigator.context!.read(verifyEmailOtpVM)..emailTEC.text = emailTEC.text;
      notifyListeners();
      if (r.data!.emailverify == 1)
        navigator.context!.navigateReplace(DashBoardScreen());
      else
        navigator.context!.navigateReplace(OtpVerificationScreen());
    });
  }

  _handleError(dynamic error) async {
    var errorString = ((error is Failure) ? error.message : '$error');
    await Fluttertoast.showToast(
        msg: errorString,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: error.message.contains("password") ? 2 : 1,
        backgroundColor: error.message.contains("password")
            ? Colors.black
            : AppColor.deepDarkOrange,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
