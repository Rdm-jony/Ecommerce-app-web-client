import 'package:e_commerce_app_bloc/Authentication/Sign_in/Screen/Layout_screen.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_in/Ui/Sign_in_screen.dart';
import 'package:e_commerce_app_bloc/SignUpForm/Screen/SignUpFormLayout_screen.dart';
import 'package:e_commerce_app_bloc/SignUpForm/Ui/SignUp_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sign_up_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SigninState();
}

class _SigninState extends State<SignUp> {
  final SignUpBloc signUpBloc = SignUpBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  var visibility = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: signUpBloc,
      listenWhen: (previous, current) => current is SignUpActionState,
      buildWhen: (previous, current) => current is! SignUpActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is SignUpSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("successfully loged in!")));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpFormLayout(),
              ));
        } else if (state is SignUpErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is SignUpToSignInState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInLayout(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.orange,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                ),
                Text(
                  "Sign Up",
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
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  height: 600,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Text(
                          "Welcome Back!",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Glad to see you back my buddy!"),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.maxFinite,
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
                        width: double.maxFinite,
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
                        width: double.maxFinite,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.orange)),
                            onPressed: () {
                              signUpBloc.add(SignUpStateEvent(
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
                          Text("Already have an account?"),
                          InkWell(
                            onTap: () => signUpBloc.add(SignUpToSignInEvent()),
                            child: Text(
                              "SignIn",
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
        );
      },
    );
  }
}
