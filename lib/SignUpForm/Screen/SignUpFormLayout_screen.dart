import 'package:e_commerce_app_bloc/SignUpForm/Ui/SignUp_form_screen.dart';
import 'package:e_commerce_app_bloc/SignUpForm/Ui/SignUp_form_screen_web.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class SignUpFormLayout extends StatefulWidget {
  const SignUpFormLayout({super.key});

  @override
  State<SignUpFormLayout> createState() => _SignUpFormLayoutState();
}

class _SignUpFormLayoutState extends State<SignUpFormLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constarins) {
        if (constarins.minWidth > 600) {
          return SignUpFormWeb();
        }
        return SignUpForm();
      },
    );
  }
}
