import 'package:e_commerce_app_bloc/Authentication/Sign_up/Screen/SignUpLayout_screen.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Screen/NavbarLayout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../bloc/sign_in_bloc.dart';

class SigninWeb extends StatefulWidget {
  const SigninWeb({super.key});

  @override
  State<SigninWeb> createState() => _SigninWebState();
}

class _SigninWebState extends State<SigninWeb> {
  final SignInBloc signInBloc = SignInBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  var visibility = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      bloc: signInBloc,
      listenWhen: (previous, current) => current is SignInActionState,
      buildWhen: (previous, current) => current is! SignInActionState,
      listener: (context, state) {
        
        // TODO: implement listener
        if (state is SignInSuccessState) {
          context.go("/");
        } else if (state is SignInErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is SignInToSignUpState) {
          context.go("/signUp");
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.orange,
          body: Center(
            child: Container(
              width: 50.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Glad to see you back my buddy!"),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                label: Text("Email"),
                                prefixIcon: Icon(Icons.email_outlined)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            obscureText: visibility,
                            obscuringCharacter: "*",
                            controller: _passController,
                            decoration: InputDecoration(
                                label: Text("Password"),
                                suffixIcon: visibility
                                    ? IconButton(
                                        onPressed: () {
                                          visibility = false;
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.visibility),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          visibility = true;
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.visibility_off),
                                      ),
                                prefixIcon: Icon(Icons.password)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.orange)),
                              onPressed: () {
                                signInBloc.add(SignInStateEvent(
                                    userEmail: _emailController.text.toString(),
                                    userPass: _passController.text.toString()));
                              },
                              child: Text("Log In")),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("not a member?"),
                            InkWell(
                              onTap: () =>
                                  signInBloc.add(SignInToSignUpEvent()),
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
