import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUpRepo {
  static Future<String> SignUpWithEmail(emailAddress, password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
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
        return "true";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return e.code;
      }
    } catch (e) {
      print(e);
    }
    return "something wrong";
  }
}
