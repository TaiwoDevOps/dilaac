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
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart';
import 'loader_vm.dart';

class UserProfileVM extends ChangeNotifier {
  final userProfileApi = UserProfileApi();

  String? _loginTokenModel;
  String? get loginTokenModel => _loginTokenModel;

  set loginTokenModel(String? val) {
    _loginTokenModel = val;
    notifyListeners();
  }

  UserProfileModel? _userProfileModel;
  UserProfileModel? get userProfileModel => _userProfileModel;

  set userProfileModel(UserProfileModel? val) {
    _userProfileModel = val;
    notifyListeners();
  }

  bool showBottom = false;

  LoaderVM get loader => navigator.context!.read(loaderVM);

  init() async {
    loginTokenModel = await LocalStorage.getLoginData();
  }

  //Login Request
  Future getProfile() async {
    loader.isLoading = true;

    var getProfileREQ =
        await userProfileApi.getUserProfile(token: loginTokenModel!);

    await _handelUserProfile(getProfileREQ);

    loader.isLoading = false;
  }

  Future _handelUserProfile(Either<Failure, UserProfileModel> loginREQ) async {
    return loginREQ.fold((l) => _handleError(l), (r) async {
      userProfileModel = r;
      notifyListeners();
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
