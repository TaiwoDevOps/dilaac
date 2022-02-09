import 'dart:convert';
import 'dart:io';

import 'package:dilaac/common/errors/failure.dart';
import 'package:dilaac/models/auth_models.dart';
import 'package:dilaac/network_layer/helper/api_helper.dart';
import 'package:dilaac/network_layer/network/base_repository.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/urls.dart';
import 'package:dartz/dartz.dart' show Either, Right, Left;

class Auth extends BaseRepository {
  final apiHelper = ApiHelper();

  Future<Either<Failure, RegisterModel>> createAccount({
    required String firstName,
    required String lastName,
    required String businessName,
    required String phoneNumber,
    required String country,
    required String email,
    required String password,
    required String projectName,
    required String countryCode,
  }) async {
    return await isDeviceOffline()
        ? informDeviceIsOffline()
        : _createAccount(
            businessName: businessName,
            projectName: projectName,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            country: country,
            email: email,
            password: password,
            countryCode: countryCode,
          );
  }

  Future<Either<Failure, RegisterModel>> _createAccount({
    required String firstName,
    required String lastName,
    required String businessName,
    required String phoneNumber,
    required String country,
    required String email,
    required String password,
    required String projectName,
    required String countryCode,
  }) async {
    try {
      var header = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
      };

      var body = {
        "businessName": businessName,
        "name": firstName + " " + lastName,
        "projectName": projectName,
        "emailAddress": email,
        "countryCode": countryCode,
        "country": country,
        "mobileNumber": phoneNumber,
        "password": password
      };

      final response = await apiHelper.postHttpReq(
          url: ApiURL.register, body: body, headers: header);

      var data = json.decode(response);
      Log().debug("The complaint response ", data);

      if (data['error']) {
        return Left(Failure(message: json.decode(response)['message']));
      } else if (!data['error'])
        return Right(RegisterModel.fromJson(response));
      else
        return Left(Failure(message: json.decode(response)['message']));
    } catch (e) {
      return Left(Failure(message: 'A Server Error Has Occurred\n$e'));
    }
  }

  Future<Either<Failure, VerifyOtpModel>> verifyOtpEmail(
      {required String code, required String email}) async {
    return await isDeviceOffline()
        ? informDeviceIsOffline()
        : _verifyOtpEmail(code: code, email: email);
  }

  Future<Either<Failure, VerifyOtpModel>> _verifyOtpEmail(
      {required String code, required String email}) async {
    try {
      var body = {
        "otp": code,
        "user": email,
      };

      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
      };

      final response = await apiHelper.postHttpReq(
          url: ApiURL.verifyOTP, headers: headers, body: body);
      var data = jsonDecode(response);
      if (data['error']) {
        return Left(Failure(message: json.decode(response)['message']));
      } else if (!data['error'])
        return Right(VerifyOtpModel.fromJson(data));
      else {
        return Left(Failure(message: json.decode(response)['message']));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }

  Future<Either<Failure, VerifyOtpModel>> resendOtpEmail(
      {required String email}) async {
    return await isDeviceOffline()
        ? informDeviceIsOffline()
        : _resendOtpEmail(email: email);
  }

  Future<Either<Failure, VerifyOtpModel>> _resendOtpEmail(
      {required String email}) async {
    try {
      var body = {
        "user": email,
      };

      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
      };

      final response = await apiHelper.postHttpReq(
          url: ApiURL.resentOtp, headers: headers, body: body);
      var data = jsonDecode(response);
      if (data['error']) {
        return Left(Failure(message: json.decode(response)['message']));
      } else if (!data['error'])
        return Right(VerifyOtpModel.fromJson(data));
      else {
        return Left(Failure(message: json.decode(response)['message']));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }

  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password}) async {
    return await isDeviceOffline()
        ? informDeviceIsOffline()
        : _login(email: email, password: password);
  }

  Future<Either<Failure, LoginModel>> _login(
      {required String email, required String password}) async {
    try {
      var body = {
        "user": email,
        "password": password,
      };

      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
      };

      final response = await apiHelper.postHttpReq(
          url: ApiURL.login, headers: headers, body: body);
      var data = jsonDecode(response);
      if (data['error']) {
        return Left(Failure(message: data['message']));
      } else if (!data['error'])
        return Right(LoginModel.fromJson(response));
      else {
        return Left(Failure(message: data['message']));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
