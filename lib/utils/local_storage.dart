import 'package:dilaac/models/auth_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'log.dart';

class SharedPrefKeys {
  static const LOGIN_MODEL = 'LOGIN_MODEL';
  static const USER_DATA_MODEL = 'USER_DATA_MODEL';
  static const NEW_USER = 'NEW_USER';
  static const PASS = 'PASS';
}

class LocalStorage {
  static Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  static FlutterSecureStorage get securePref => FlutterSecureStorage();

  static Future<String?> getLoginData() async {
    try {
      return (await securePref.read(key: SharedPrefKeys.LOGIN_MODEL)) != null
          ? await securePref.read(key: SharedPrefKeys.LOGIN_MODEL)
          : null;
    } catch (e) {
      await securePref.delete(key: SharedPrefKeys.LOGIN_MODEL);
    }
  }

  static Future eraseLoginData() async {
    var token = (await getLoginData());
    if (token != null) {
      await securePref.delete(key: SharedPrefKeys.LOGIN_MODEL);
      await securePref.delete(key: SharedPrefKeys.USER_DATA_MODEL);
      // await securePref.delete(key: SharedPrefKeys.PASS);
      // await SocialAuth().logoutSocialAuths();

      await saveLoginData(
        token: token,
      );
    }
  }

  static Future<void> saveLoginData({required String token}) async {
    securePref
      ..delete(key: SharedPrefKeys.LOGIN_MODEL)
      ..write(
        key: SharedPrefKeys.LOGIN_MODEL,
        value: token,
      );
  }

  static Future<void> saveLoginPass({required String pass}) async {
    securePref
      ..write(
        key: SharedPrefKeys.PASS,
        value: pass,
      );
  }

  static Future<String?> getLoginPass({required String pass}) async {
    try {
      return (await securePref.read(key: SharedPrefKeys.PASS));
    } catch (e) {
      await securePref.delete(key: SharedPrefKeys.PASS);
    }
  }

  static Future eraseItem({required key}) async {
    var data = await keyExists(key: key);
    if (data) securePref.delete(key: '$key');
  }

  static Future<bool> keyExists({required String key}) async {
    if (securePref.containsKey(key: key) != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> getItemData({required key}) async {
    return await securePref.containsKey(key: '$key')
        ? securePref.read(key: '$key')
        : null;
  }
}
