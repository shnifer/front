import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HttpConnectController extends GetxController{
  static const defaultAddress = "xiiith.ru";
  static const storageKey = "http_address";
  static const stats = "/debug/stat";

  HttpConnectController() : super(){
    _autorefresher();
  }

  var address = defaultAddress.obs;
  var autoRefresh = false.obs;
  final stat = ServerStat();

  void initLocalSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final addr = prefs.getString(storageKey) ?? defaultAddress;
    address.value = addr;
    refreshOnline();
  }

  void setAddress(String addr) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(storageKey, addr);
    address.value = addr;
    refreshOnline();
  }

  Future refreshOnline() async{
    try {
      final resp = await fetch(stats);
      stat.online.value = resp.statusCode == 200;
      final json = jsonDecode(resp.body);
      stat.gtime.value = json['world']['gtime'];
      stat.ticking.value = json['world']['is_ticking'];
      stat.paused.value = json['world']['paused'];
      stat.stage.value = json['world']['stage'];
    } catch (e) {
      print("ERROR refreshOnline: $e");
      stat.online.value = false;
      stat.gtime.value = 0;
      stat.ticking.value = false;
      stat.paused.value = false;
      stat.stage.value = "";
    }
  }

  void _autorefresher() async{
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (autoRefresh.value) await refreshOnline();
    }
  }

  //move access method to repo???
  Future<http.Response> fetch(String path) {
      return http.get(Uri.http(address.value, path)).
      timeout(
        const Duration(seconds: 1),
        onTimeout: () => http.Response('Timeout', 500),
      );
  }

  Future<http.Response> post(String path, {Object? body}) {
    return http.post(Uri.http(address.value, path), body: body).
    timeout(
      const Duration(seconds: 1),
      onTimeout: () => http.Response('Timeout', 500),
    );
  }

  Future<http.Response> delete(String path, {Object? body}) {
    return http.delete(Uri.http(address.value, path), body: body).
    timeout(
      const Duration(seconds: 1),
      onTimeout: () => http.Response('Timeout', 500),
    );
  }
}

class ServerStat{
  var online = false.obs;
  var gtime = 0.0.obs;
  var ticking = false.obs;
  var paused = false.obs;
  var stage = "".obs;
}