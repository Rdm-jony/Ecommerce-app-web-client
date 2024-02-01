import 'dart:convert';

import 'package:e_commerce_app_bloc/AdminPanel/ManageUser/Model/UserModel.dart';
import 'package:http/http.dart' as http;

class ManageUserRepo {
  static Future<List<userDataModel>> fatchUserData() async {
    List<userDataModel> allUsers = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.213.133:5000/allUsers"));
      if (response.statusCode == 200) {
        List jsonReponse = jsonDecode(response.body);
        for (var i = 0; i < jsonReponse.length; i++) {
          userDataModel user = userDataModel.fromJson(jsonReponse[i]);
          allUsers.add(user);
        }
        return allUsers;
      }
    } catch (e) {}
    return [];
  }

  static Future<bool> userToAdmin(email, role) async {
    try {
      var response = await http.put(
          Uri.parse("http://192.168.213.133:5000/allUsers/${email}"),
          headers: {"Content-Type": "applicaton/json"},
          body: jsonEncode({"role": role}));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["modifiedCount"] == 1) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
