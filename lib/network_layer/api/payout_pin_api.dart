import 'dart:convert';
import 'dart:io';

import 'package:dilaac/common/errors/failure.dart';
import 'package:dilaac/models/auth_models.dart';
import 'package:dilaac/network_layer/helper/api_helper.dart';
import 'package:dilaac/network_layer/network/base_repository.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/urls.dart';
import 'package:dartz/dartz.dart' show Either, Right, Left;

import '../../presentation/journeys/auth/login_screen.dart';
import '../../utils/navigator.dart';

class PayoutPinApi extends BaseRepository {
  final apiHelper = ApiHelper();

  Future<Either<Failure, dynamic>> setUserPin(
      {required String pin, required String token}) async {
    return await isDeviceOffline()
        ? informDeviceIsOffline()
        : _setUserPin(pin: pin, token: token);
  }

  Future<Either<Failure, dynamic>> _setUserPin(
      {required String pin, required String token}) async {
    try {
      var body = {
        "pin": pin,
      };

      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      final response = await apiHelper.postHttpReq(
          url: ApiURL.login, headers: headers, body: body);
      var data = jsonDecode(response);
      if (data['error']) {
        if (data['message'] == "Authorization expire")
          navigator.context!.navigateReplace(LoginPage());
        return Left(Failure(message: data['message']));
      } else if (!data['error'])
        return Right(response);
      else {
        return Left(Failure(message: data['message']));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
