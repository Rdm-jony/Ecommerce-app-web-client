import 'package:e_commerce_app_bloc/Authentication/Sign_in/Ui/Sign_in_screen.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_in/Ui/Sign_in_screen_web.dart';
import 'package:e_commerce_app_bloc/SignUpForm/Ui/SignUp_form_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class SignInLayout extends StatefulWidget {
  const SignInLayout({super.key});

  @override
  State<SignInLayout> createState() => _SignInLayoutState();
}

class _SignInLayoutState extends State<SignInLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return SigninWeb();
        }
        return Signin();
      },
    );
  }
}
