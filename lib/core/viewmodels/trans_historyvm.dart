import 'package:dartz/dartz.dart';
import 'package:dilaac/common/errors/failure.dart';
import 'package:dilaac/models/auth_models.dart';
import 'package:dilaac/models/trans_history_model.dart';
import 'package:dilaac/models/user_profile.dart';
import 'package:dilaac/network_layer/api/auth_api.dart';
import 'package:dilaac/network_layer/api/get_user_profile_api.dart';
import 'package:dilaac/network_layer/api/trans_history_api.dart';
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

class TransHistoryVM extends ChangeNotifier {
  final transHistApi = TransHistoryApi();

  String? _loginTokenModel;
  String? get loginTokenModel => _loginTokenModel;

  set loginTokenModel(String? val) {
    _loginTokenModel = val;
    notifyListeners();
  }

  TransHistoryModel? _transHistoryModel;
  TransHistoryModel? get transHistoryModel => _transHistoryModel;

  set transHistoryModel(TransHistoryModel? val) {
    _transHistoryModel = val;
    notifyListeners();
  }

  bool showBottom = false;

  LoaderVM get loader => navigator.context!.read(loaderVM);

  init() async {
    loginTokenModel = await LocalStorage.getLoginData();
  }

  //Login Request
  Future getTransHist({String? type, String? start, String? end}) async {
    loader.isLoading = true;
    transHistoryModel = null;
    var getProfileREQ = await transHistApi.getTransHistory(
      token: loginTokenModel!,
      type: type,
      start: start,
      end: end,
    );

    await _handelTransHist(getProfileREQ);

    loader.isLoading = false;
  }

  Future _handelTransHist(Either<Failure, TransHistoryModel> loginREQ) async {
    return loginREQ.fold((l) => _handleError(l), (r) async {
      transHistoryModel = r;
      notifyListeners();
    });
  }

  _handleError(dynamic error) async {
    var errorString = ((error is Failure) ? error.message : '$error');
    transHistoryModel = null;
    notifyListeners();
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
