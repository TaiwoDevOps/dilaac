import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApiURL {
  static String _baseUrl = 'http://104.248.131.51:3005';
  static String _clientBaseUrl = '$_baseUrl/v1/client';

  //Authentication
  static final String register = '$_clientBaseUrl/auth/register';
  static final String resentOtp = '$_clientBaseUrl/auth/resendOTP';
  static final String verifyOTP = '$_clientBaseUrl/auth/verifyOTP';
  static final String login = '$_clientBaseUrl/auth/login';
  static final String refreshToken = '$_clientBaseUrl/auth/refreshToken';
  static final String getUserProfile = '$_clientBaseUrl/profile/getProfile';
  static final String getPaymentLink = '$_clientBaseUrl/payment/defaultLink';
  static final String setPin = '$_clientBaseUrl/profile/setPin';

  static String transactionHistory(String? type, start, end) =>
      '$_clientBaseUrl/transaction/history?type=$type&start=$start&end=$end';
}
