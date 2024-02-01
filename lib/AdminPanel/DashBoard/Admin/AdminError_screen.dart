import 'package:e_commerce_app_bloc/Bottom_nav/Screen/NavbarLayout_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';

class AdminErrorPage extends StatelessWidget {
  const AdminErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("unathorized access "),
            ElevatedButton(
                onPressed: () {
                  if (kIsWeb) {
                    context.go("/");
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavbarLayout(),
                        ));
                  }
                },
                child: Text("Go Home"))
          ],
        ),
      ),
    );
  }
}
