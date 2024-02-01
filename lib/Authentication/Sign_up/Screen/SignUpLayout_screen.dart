import 'package:e_commerce_app_bloc/Authentication/Sign_up/ui/Sign_up_screen.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_up/ui/Sign_up_screen_web.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class SignUpLayout extends StatefulWidget {
  const SignUpLayout({super.key});

  @override
  State<SignUpLayout> createState() => _SignUpLayoutState();
}

class _SignUpLayoutState extends State<SignUpLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return SignUpWeb();
        }
        return SignUp();
      },
    );
  }
}
