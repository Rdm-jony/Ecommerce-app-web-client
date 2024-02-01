import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';

class AdsProductsRepo {
  static Future<List<TopProductDataModel>> fatchAdsProducts() async {
    List<TopProductDataModel> adsProducts = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.213.133:5000/adsProducts"));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          TopProductDataModel product =
              TopProductDataModel.fromJson(jsonResponse[i]);
          adsProducts.add(product);
        }
        return adsProducts;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
