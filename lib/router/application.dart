import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:remember/utils/regex_utils.dart';

class Application {
  static final router = FluroRouter();

  static push(BuildContext context, String path, Map<String, dynamic> params,
      {bool clearStack = false,
      TransitionType transition = TransitionType.inFromRight}) {
    String query = "";
    int index = 0;
    for (var key in params.keys) {
      String value = params[key].toString();
      if (value.startsWith('http')) {
        value = Uri.encodeComponent(value);
      } else if (RegexUtils.isZh(value)) {
        value = jsonEncode(Utf8Encoder().convert(value));
      }

      if (index == 0) {
        query = "?";
      } else {
        query = query + "\&";
      }

      query += "$key=$value";
      index++;
    }
    path = path + query;
    return router.navigateTo(context, path,
        clearStack: clearStack, transition: transition);
  }

  static pop(BuildContext context) {
    router.pop(context);
  }
}
