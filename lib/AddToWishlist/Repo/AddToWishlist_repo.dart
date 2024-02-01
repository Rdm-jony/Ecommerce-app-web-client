import 'dart:convert';

import 'package:http/http.dart' as http;

class AddToWishlistRepo {
  static Future<bool> deleteCartFunction(cartId) async {
    try {
      var response = await http.delete(
          Uri.parse("http://192.168.213.133:5000/addToWishlist/${cartId}"));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["modifiedCount"] == 1) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
