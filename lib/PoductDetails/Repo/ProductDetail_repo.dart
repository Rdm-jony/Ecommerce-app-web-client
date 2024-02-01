import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ProductsDetailRepo {
  static Future<Map> addToCartFunction(cartDetail) async {
    print(cartDetail);
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http.post(
          Uri.parse("http://192.168.213.133:5000/addToCart/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartDetail));
      var jsonReponse = jsonDecode(response.body);
      return jsonReponse;
    } catch (e) {
      print(e);
    }
    return {};
  }

  static Future<Map> addToWishListFunction(cartDetail) async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http.post(
          Uri.parse("http://192.168.213.133:5000/addToWishList/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartDetail));
      var jsonReponse = jsonDecode(response.body);
      return jsonReponse;
    } catch (e) {
      print(e);
    }
    return {};
  }
}
