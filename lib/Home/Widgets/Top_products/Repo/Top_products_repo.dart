import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';

class TopProductsRepo {
  static Future<List<TopProductDataModel>> fatchTopProducts() async {
    List<TopProductDataModel> topProducts = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.213.133:5000/topProducts"));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          TopProductDataModel product =
              TopProductDataModel.fromJson(jsonResponse[i]);
          topProducts.add(product);
        }
        return topProducts;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
