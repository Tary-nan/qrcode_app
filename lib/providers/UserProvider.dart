import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode_app/exceptions/InvalidQrCodeException.dart';
import 'package:qrcode_app/exceptions/NoNetworkException.dart';
import 'package:qrcode_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {

  bool isloading = false;

  User _user;

  User get user => user;

  static const baseUrl = 'https://presence.nan.ci';
  static const timeout = Duration(seconds: 30);
  String KEY_USER = 'KEY_USER';
  

  void setLogin({username, password}) {
    //TODO: set login
    _user = User(username: username, password: password);

  }

    get message => _message;

  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(KEY_USER);
    if(res == null) return false;
    _user = User.fromJson(json.decode(res));
    return true;
  }

  Future<void> launch({String url, Map<String, dynamic> data, int success: 200, Function callback}) async{
    try {
      http.Response response = await http.post('$baseUrl/$url', body: data).timeout(timeout, onTimeout: () => throw NoNetworkException());
      Map<String, dynamic> res;

      if(response.body.isNotEmpty)
        res = json.decode(response.body);
      else
        res = {};
      if (response.statusCode == success) {
        if(res["status"] == true){
          _message = res['message'];
          await callback(data: res);
        }else if(res['status'] == false) {
          _message = res['message'];
          throw InvalidQrCodeException();
        }

      }
    } catch (e) {
      throw e;
    }
  }


  Future<int> login() async {
        Function callback = ({data}) async {
          print(data);
        _user = User.fromJson(data['user']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(KEY_USER, json.encode(user.toJson()));
    };
    await launch(url: 'mobilelogin/', data: {'username': user.username,'password': user.password}, callback: callback);
    return 1;
  }

  String _message;

  Future<String> fetchScan({String scan})async {
   try {
     isloading = true;
     notifyListeners();
     String ip = await (Connectivity().getWifiIP());
     await launch(url: 'scanner/', data: {'username': '${user.username}', 'ip_adrrese':'$ip','qrcode':'$scan'}, callback: ({data}) async {
       _message = data["message"];
     });
     print("messsage $_message");
     return _message;
   } catch (e){
     throw e;
   } finally {
     isloading = false;
     notifyListeners();
   }
  }

  Future<void> logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(KEY_USER);
    _user = null;
  }
}