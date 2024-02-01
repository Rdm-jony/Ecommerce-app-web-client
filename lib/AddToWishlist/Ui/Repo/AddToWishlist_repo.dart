import 'dart:convert';

import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddToWishlistRepo {
  static Future<List<TopProductDataModel>> fatchInitialCarts() async {
    List<TopProductDataModel> addToCartItems = [];
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http
          .get(Uri.parse("http://192.168.213.133:5000/addToWishlist/${email}"));

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
