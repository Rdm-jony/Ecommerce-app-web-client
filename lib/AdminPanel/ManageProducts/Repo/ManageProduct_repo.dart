import 'dart:convert';

import 'package:http/http.dart' as http;

class ManageProductRepo {
  static Future<bool> adsProductInsert(cartDetails) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.213.133:5000/adsProduct"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartDetails));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["insertedId"] != null) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> topProductInsert(cartDetails) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.213.133:5000/topProduct"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartDetails));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["insertedId"] != null) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> adsProductDelete(cartId) async {
    try {
      var response = await http.delete(
          Uri.parse("http://192.168.213.133:5000/adsProduct/${cartId}"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["deletedCount"] == 1) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> topProductDelete(cartId) async {
    try {
      var response = await http.delete(
          Uri.parse("http://192.168.213.133:5000/topProduct/${cartId}"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["deletedCount"] == 1) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> deleteProduct(cartId) async {
    try {
      var response = await http.delete(
          Uri.parse("http://192.168.213.133:5000/allProduct/${cartId}"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["deletedCount"] == 1) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
