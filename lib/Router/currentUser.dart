import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class CurrentUser {
  static getCurrentUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> isAdmin() async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http
          .get(Uri.parse("http://192.168.213.133:5000/user/admin/${email}"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["isAdmin"] == true) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
