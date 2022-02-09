import 'dart:convert';
import 'dart:io';

import 'package:dilaac/common/errors/failure.dart';
import 'package:dilaac/models/auth_models.dart';
import 'package:dilaac/models/user_profile.dart';
import 'package:dilaac/network_layer/helper/api_helper.dart';
import 'package:dilaac/network_layer/network/base_repository.dart';
import 'package:dilaac/presentation/journeys/auth/login_screen.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:dilaac/utils/urls.dart';
import 'package:dartz/dartz.dart' show Either, Right, Left;

class UserProfileApi extends BaseRepository {
  final apiHelper = ApiHelper();
  Future<Either<Failure, UserProfileModel>> getUserProfile(
      {required String token}) async {
    return await isDeviceOffline()
        ? informDeviceIsOffline()
        : _getUserProfile(
            token: token,
          );
  }

  Future<Either<Failure, UserProfileModel>> _getUserProfile(
      {required String token}) async {
    try {
      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      final response = await apiHelper.httpGetHelper(
        url: ApiURL.getUserProfile,
        headers: headers,
      );
      var data = jsonDecode(response);
      if (data['error']) {
        if (data['message'].toString().toLowerCase() ==
            "authorization expire") {
          Log().debug("The ${data['message']}");
          navigator.context!.navigateReplace(LoginPage());
        }
        return Left(Failure(message: data['message']));
      } else if (!data['error'])
        return Right(UserProfileModel.fromJson(data));
      else {
        if (data['message'].toString().toLowerCase() ==
            "authorization expire") {
          navigator.context!.navigateReplace(LoginPage());
        }
        return Left(Failure(message: data['message']));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
