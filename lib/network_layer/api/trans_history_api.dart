import 'dart:convert';
import 'dart:io';

import 'package:dilaac/common/errors/failure.dart';
import 'package:dilaac/models/auth_models.dart';
import 'package:dilaac/models/trans_history_model.dart';
import 'package:dilaac/models/user_profile.dart';
import 'package:dilaac/network_layer/helper/api_helper.dart';
import 'package:dilaac/network_layer/network/base_repository.dart';
import 'package:dilaac/presentation/journeys/auth/login_screen.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:dilaac/utils/urls.dart';
import 'package:dartz/dartz.dart' show Either, Right, Left;

class TransHistoryApi extends BaseRepository {
  final apiHelper = ApiHelper();
  Future<Either<Failure, TransHistoryModel>> getTransHistory(
      {required String token, String? type, String? start, String? end}) async {
    return await isDeviceOffline()
        ? informDeviceIsOffline()
        : _getTransHistory(
            token: token,
            type: type,
            start: start,
            end: end,
          );
  }

  Future<Either<Failure, TransHistoryModel>> _getTransHistory(
      {required String token, String? type, String? start, String? end}) async {
    try {
      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      final response = await apiHelper.httpGetHelper(
        url: ApiURL.transactionHistory(type, start, end),
        headers: headers,
      );
      var data = jsonDecode(response);
      if (data['error']) {
        if (data['message'] == "Authorization expire")
          navigator.context!.navigateReplace(LoginPage());
        return Left(Failure(message: data['message']));
      } else if (!data['error'])
        return Right(TransHistoryModel.fromJson(data));
      else {
        return Left(Failure(message: data['message']));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
