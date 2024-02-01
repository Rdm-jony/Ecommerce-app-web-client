import 'dart:async';

import 'package:e_commerce_app_bloc/Authentication/Sign_in/Screen/Layout_screen.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_in/Ui/Sign_in_screen.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Screen/NavbarLayout_screen.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Ui/Bottem_navbar.dart';
import 'package:e_commerce_app_bloc/Home/Ui/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ecommrce App",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void whereToGo() {
    Timer(Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var isLogedIn = prefs.getBool("KEYLOGIN");

      if (isLogedIn != null) {
        if (isLogedIn) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavbarLayout(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInLayout(),
              ));
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInLayout(),
            ));
      }
    });
  }
}
