import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInRepo {
  static Future<String> SignInWithEmail(emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user?.uid != null) {
        var response = await http.post(
            Uri.parse("http://192.168.213.133:5000/jwt"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": emailAddress}));
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
    
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('jwtToken', jsonResponse["token"]);
          return "true";
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return e.code;
      } else if (e.code == 'wrong-password') {
        return e.code;
      }
    }
    return "something wrong";
  }
}
