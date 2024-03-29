import 'dart:convert';

import 'package:dilaac/utils/pretty_json.dart';
import 'package:meta/meta.dart';

class Log {
  factory Log() => _instance!;

  Log._(this.production);

  static void init([bool production = false]) => _instance = Log._(production);

  static Log? _instance;

  final bool production;

  String debug(String tag, [dynamic payload]) {
    var output;
    if (production) return '';
    try {
      output = generator('=', tag, jsonPretty(json.decode(payload)));
    } catch (e) {
      output = generator('=', tag, payload);
    }
    print(output);

    return output;
  }

  String error(String tag, [dynamic payload]) {
    if (production) return '';
    final output = generator('*', tag, payload);
    print(output);
    return output;
  }

  @visibleForTesting
  String generator(String delime, String tag, [dynamic payload]) {
    if (production) return '';
    var _ = '';

    final _d = delime.padRight(20, delime);
    _ += '\n$delime> $tag $_d>\n';
    if (payload != null) {
      _ += '$payload \n$_d\n';
    }

    return _;
  }
}
