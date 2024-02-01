import 'dart:convert';

import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartRepo {
  static Future<List<TopProductDataModel>> fatchInitialCarts() async {
    List<TopProductDataModel> addToCartItems = [];
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http.get(
          Uri.parse("http://192.168.213.133:5000/addToCart/${email}"),
          headers: {"auhtorization": "Bearer ${prefs.getString('jwtToken')}"});
      print(prefs.getString('jwtToken'));
      if (response.statusCode == 200) {
        final List jsonResponse = jsonDecode(response.body);

        for (int i = 0; i < jsonResponse.length; i++) {
          TopProductDataModel product =
              TopProductDataModel.fromJson(jsonResponse[i]);

          addToCartItems.add(product);
        }

        return addToCartItems;
      }
    } catch (e) {
      // print(e);
    }
    return [];
  }

  static Future<bool> deleteCartFunction(cartId) async {
    try {
      var response = await http
          .delete(Uri.parse("http://192.168.213.133:5000/addToCart/${cartId}"));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["modifiedCount"] == 1) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<Object> cartPayment(cartDetails) async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http.post(
          Uri.parse(
              "http://192.168.213.133:5000/create-checkout-session/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartDetails));
      if (response.statusCode == 200) {
        var jsnonResponse = jsonDecode(response.body);
        if (jsnonResponse["id"] != null) {
          return jsnonResponse;
        }
      }
    } catch (e) {
      print(e);
    }
    return {};
  }

  static Future<bool> updateCartPayment(cartId) async {
    try {
      var email = FirebaseAuth.instance.currentUser?.email;

      var response = await http.put(
          Uri.parse("http://192.168.213.133:5000/updatePayment/${cartId}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email}));
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        if (jsonReponse["acknowledged"] == true) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
