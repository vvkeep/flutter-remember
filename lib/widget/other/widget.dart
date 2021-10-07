import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

GetBar errorBar(String msg) {
  return GetBar(
    duration: Duration(seconds: 1),
    messageText: Text(msg, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.red,
  );
}

GetBar successBar(String msg) {
  return GetBar(
    duration: Duration(seconds: 1),
    messageText: Text(msg, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.blue,
  );
}

GetBar infoBar(String msg) {
  return GetBar(
    duration: Duration(seconds: 1),
    messageText: Text(msg, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.grey,
  );
}
