import 'dart:convert';

import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:http/http.dart' as http;

class AllProsucts {
  static Future<List<TopProductDataModel>> fatchAllProducts() async {
    List<TopProductDataModel> allProducts = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.213.133:5000/allProducts"));
      if (response.statusCode == 200) {
        final List jsonResponse = jsonDecode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          TopProductDataModel product =
              TopProductDataModel.fromJson(jsonResponse[i]);
          allProducts.add(product);
        }
        return allProducts;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List> fatchCategory() async {
    try {
      var response = await http
          .get(Uri.parse("http://192.168.213.133:5000/productsCategory"));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<TopProductDataModel>> fatchAllCategoryProducts(
      categoryName) async {
    List<TopProductDataModel> allProducts = [];
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.213.133:5000/allProducts?categoryName=${categoryName}"));
      if (response.statusCode == 200) {
        final List jsonResponse = jsonDecode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          TopProductDataModel product =
              TopProductDataModel.fromJson(jsonResponse[i]);
          allProducts.add(product);
        }
        return allProducts;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}

class SearchItem {
  static Future<List<TopProductDataModel>> fatchSearchItem(searchText) async {
    List<TopProductDataModel> searchItems = [];
    try {
      var response = await http.get(
          Uri.parse("http://192.168.213.133:5000/searchItem/${searchText}"));
      if (response.statusCode == 200) {
        final List jsonResponse = jsonDecode(response.body);
        for (var i = 0; i < jsonResponse.length; i++) {
          final TopProductDataModel product =
              TopProductDataModel.fromJson(jsonResponse[i]);
          searchItems.add(product);
        }
        return searchItems;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
