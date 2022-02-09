import 'dart:io';

import 'package:dilaac/common/exceptions/exceptions.dart';
import 'package:dilaac/network_layer/network/authenticated_http_client.dart';
import 'package:dilaac/utils/local_storage.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dio/dio.dart';

class ApiHelper extends AuthenticatedDioClient {
  // Future<String> get localUserRefreshToken async =>
  //     (await LocalStorage.getLoginData())!.data!.refreshToken!;

  Future<String> getReq({
    /// Request Url
    required String url,

    /// Request Headers
    Map<String, String>? headers,

    /// Request's queryParameters
    Map<String, dynamic>? queryParameters,

    /// Override default options
    Options? options,

    /// Progress report for data download
    onReceiveProgress,
  }) async {
    String? responseJson;
    try {
      // Make Request

      final response = await get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
        onReceiveProgress: onReceiveProgress,
      );

      // Log data response
      Log().debug(url, response.data);

      responseJson = _returnResponse(response);
    } on SocketException {
      // Handle Exceptions
      throw ServerException(message: 'No Internet connection');
    } catch (e) {
      // Catch Error
      if (e is Response<dynamic>) {
        Log().debug(e.data);

        throw e.data;
      } else if (e.toString().toLowerCase().contains('time')) {
        throw 'Sever Took too long to Respond';
      } else {
        Log().debug(e.toString());

        rethrow;
      }
    }
    return responseJson;
  }

  Future<Response> getRaw({
    /// Request Url
    required String url,

    /// Request Headers
    Map<String, String>? headers,

    /// Request's queryParameters
    Map<String, dynamic>? queryParameters,

    /// Override default options
    Options? options,

    /// Progress report for data download
    onReceiveProgress,
  }) async {
    Response responseJson;
    try {
      // Make Request
      Log().debug('Query params', queryParameters);
      final response = await get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
        onReceiveProgress: onReceiveProgress,
      );

      // Log data response
      Log().debug(url, response.data);

      responseJson = response;
    } on SocketException {
      // Handle Exceptions
      throw ServerException(message: 'No Internet connection');
    } catch (e) {
      // Catch Error
      if (e is Response<dynamic>) {
        Log().debug(e.data);
        throw e.data;
      } else if (e.toString().toLowerCase().contains('time')) {
        throw 'Sever Took too long to Respond';
      } else {
        Log().debug(e.toString());

        rethrow;
      }
    }
    return responseJson;
  }

  Future<Response> deleteReq({
    /// Request Url
    required String url,

    /// Request Headers
    Map<String, String>? headers,

    /// Request's queryParameters
    Map<String, dynamic>? queryParameters,

    /// Override default options
    Options? options,

    /// Progress report for data download
    onReceiveProgress,
  }) async {
    Response responseJson;
    try {
      // Make Request
      Log().debug('Delete REQ', queryParameters);
      final response = await delete(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      // Log data response
      Log().debug(url, response.data);

      responseJson = response;
    } on SocketException {
      // Handle Exceptions
      throw ServerException(message: 'No Internet connection');
    } catch (e) {
      // Catch Error
      if (e is Response<dynamic>) {
        Log().debug(e.data);
        throw e.data;
      } else if (e.toString().toLowerCase().contains('time')) {
        throw 'Sever Took too long to Respond';
      } else {
        Log().debug(e.toString());

        rethrow;
      }
    }
    return responseJson;
  }

  Future<dynamic> httpGetHelper({
    /// Request Url
    required String url,

    /// Request Headers
    Map<String, String>? headers,

    /// Progress report for data download
    onReceiveProgress,
  }) async {
    dynamic responseJson;
    try {
      // Make Request
      Log().debug('Query params $url', headers);
      final response = await httpGet(
        url,
        headers: headers,
      );

      // Log data response
      Log().debug("Log data response GET Helper  $url", response.body);

      responseJson = response.body;
    } on SocketException {
      // Handle Exceptions
      throw ServerException(message: 'No Internet connection');
    } catch (e) {
      // Catch Error
      Log().debug("The GET Helper Cath", e);

      if (e is Response<dynamic>) {
        Log().debug(e.data);
        throw e.data;
      } else if (e.toString().toLowerCase().contains('time')) {
        throw 'Sever Took too long to Respond';
      } else {
        Log().debug("The GET Helper", e);

        rethrow;
      }
    }
    return responseJson;
  }

  Future<String> postReq({
    /// Request Url
    required String url,

    /// Request Headers
    Map<String, String>? headers,

    /// Should throw error or return it
    bool throwError = true,

    /// Status code to accept as successful
    List<int>? passRange,

    /// Body of the Request
    required Map<String, dynamic> body,

    /// Request's queryParameters
    Map<String, dynamic>? queryParameters,

    /// Override default options
    Options? options,

    /// Progress report for data upload
    onSendProgress,

    /// Progress report for data download
    onReceiveProgress,
  }) async {
    Object? responseJson;
    try {
      // Make Request
      Log().debug('body', body);

      final response = await post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      // Log data response

      // Handle logic for pass range
      if (!throwError) {
        if (passRange != null) {
          for (var item in passRange) {
            (item == response.statusCode)
                ? responseJson = response.data
                : throw response.data;
          }
        } else {
          responseJson = _returnResponse(response);
        }
      } else {
        return response.data;
      }
    } on SocketException {
      // Handle Exceptions
      throw ServerException(message: 'No Internet connection');
    } catch (e) {
      // Catch Error
      if (e is Response<dynamic>) {
        Log().debug(e.data);
        throw e.data;
      } else if (e.toString().toLowerCase().contains('time')) {
        throw 'Sever Took too long to Respond';
      } else {
        Log().debug(e.toString());

        rethrow;
      }
    }

    return responseJson.toString();
  }

  Future<String> postHttpReq({
    /// Request Url
    required String url,

    /// Request Headers
    Map<String, String>? headers,

    /// Should throw error or return it
    bool throwError = true,

    /// Status code to accept as successful
    List<int>? passRange,

    /// Body of the Request
    required Map<String, dynamic> body,

    /// Request's queryParameters
    Map<String, String>? queryParameters,

    /// Override default options
    Options? options,

    /// Progress report for data upload
    onSendProgress,

    /// Progress report for data download
    onReceiveProgress,
  }) async {
    Object? responseJson;
    try {
      Log().debug('url :::: $url     body', body);

      // Make Request
      final response = await httpPost(
        url,
        data: body,
        headers: headers,
      );
      Log().debug("_postHttpReq response =======${response.body}");

      // Log data response

      // Hangle logic for pass range
      if (!throwError) {
        if (passRange != null) {
          for (var item in passRange) {
            (item == response.statusCode)
                ? responseJson = response.body
                : throw response.body;
          }
        } else {
          responseJson = _returnResponse(response);
        }
      } else {
        return response.body;
      }
    } on SocketException {
      // Handle Exceptions
      throw ServerException(message: 'No Internet connection');
    } catch (e) {
      // Catch Error
      if (e is Response<dynamic>) {
        Log().debug(e.data);
        throw e.data;
      } else if (e.toString().toLowerCase().contains('time')) {
        throw 'Sever Took too long to Respond';
      } else {
        Log().debug(e.toString());

        rethrow;
      }
    }
    return responseJson.toString();
  }

  Future<String> patchReq({
    /// Request Url
    required String url,

    /// Request Headers
    Map<String, String>? headers,

    /// Should throw error or return it
    bool throwError = true,

    /// Status code to accept as successful
    List<int>? passRange,

    /// Body of the Request
    required dynamic body,

    /// Request's queryParameters
    Map<String, dynamic>? queryParameters,

    /// Override default options
    Options? options,

    /// Progress report for data upload
    onSendProgress,

    /// Progress report for data download
    onReceiveProgress,
  }) async {
    Object? responseJson;
    try {
      Log().debug('body', body);

      // Make Request
      final response = await patch(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      // Log data response

      Log().debug(url, response.data);

      // Hangle logic for pass range
      if (!throwError) {
        if (passRange != null) {
          for (var item in passRange) {
            (item == response.statusCode)
                ? responseJson = response.data
                : throw response.data;
          }
        } else {
          responseJson = _returnResponse(response);
        }
      } else {
        return response.data;
      }
    } on SocketException {
      // Handle Exceptions
      throw ServerException(message: 'No Internet connection');
    } catch (e) {
      // Catch Error
      if (e is Response<dynamic>) {
        Log().debug(e.data);
        throw e.data;
      } else if (e.toString().toLowerCase().contains('time')) {
        throw 'Sever Took too long to Respond';
      } else {
        Log().debug(e.toString());

        rethrow;
      }
    }
    return responseJson.toString();
  }

  String _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        return '${response.data}';
      case 401:
        return response.data;
      case 422:
        return '${response.data}';
      case 404:
        throw Exception('${response.data}');

      case 403:
        throw ServerException(message: '${response.data['message']}');
      case 500:
      default:
        throw ServerException(
          message: 'Error occurred while communicating with the Server',
        );
    }
  }
}
