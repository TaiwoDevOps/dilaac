import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterModel with EquatableMixin {
  bool? error;
  String? message;

  RegisterModel({
    this.error,
    this.message,
  });

  RegisterModel copyWith({
    bool? error,
    String? message,
  }) {
    return RegisterModel(
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null ;

    return RegisterModel(
      error: map['error'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        error,
        message,
      ];
}

/************OTP Verification************/
class VerifyOtpModel {
  bool? exRespCode;
  String? exRespDesc;

  VerifyOtpModel({this.exRespCode, this.exRespDesc});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    exRespCode = json['error'];
    exRespDesc = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.exRespCode;
    data['message'] = this.exRespDesc;
    return data;
  }
}

/***************Login Model************** */

class LoginModel with EquatableMixin {
  bool? error;
  String? message;
  Token? token;

  LoginModel({this.error, this.message, this.token});

  LoginModel copyWith({bool? error, String? message, Token? token}) {
    return LoginModel(
      error: error ?? this.error,
      message: message ?? this.message,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
      'token': token?.toJson(),
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null ;

    return LoginModel(
      token: Token.fromMap(map['token']),
      message: map['message'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, message, error];
}

class Token with EquatableMixin {
  String? token;
  String? expireAt;

  Token({this.token, this.expireAt});
  Token copyWith({
    String? expireAt,
    String? token,
  }) {
    return Token(
      expireAt: expireAt ?? this.expireAt,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'expire_at': expireAt,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Token(
      token: map['token'],
      expireAt: map['expire_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, expireAt];
}
