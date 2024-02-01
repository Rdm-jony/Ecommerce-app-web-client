import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class SignUpFormRepo {
  static Future<String> formDataSendDatabase(
      name, phoneNumber, birthDate, gender) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    try {
      final userInfo = {
        "email": email,
        "name": name,
        "birthDate": birthDate,
        "gender": gender,
        "number": phoneNumber,
        "role": "user",
        "image": ""
      };

      var response = await http.post(
          Uri.parse("http://192.168.213.133:5000/registration"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userInfo));
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["insertedId"] != null) {
        return "true";
      }
    } catch (e) {
      print(e);
    }
    return "something error";
  }
}
