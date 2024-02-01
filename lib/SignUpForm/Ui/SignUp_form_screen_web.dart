import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Screen/NavbarLayout_screen.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Ui/Bottem_navbar.dart';
import 'package:e_commerce_app_bloc/Home/Ui/Home_screen.dart';
import 'package:e_commerce_app_bloc/SignUpForm/bloc/sign_up_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SignUpFormWeb extends StatefulWidget {
  const SignUpFormWeb({super.key});

  @override
  State<SignUpFormWeb> createState() => _SignUpFormWebState();
}

class _SignUpFormWebState extends State<SignUpFormWeb> {
  final SignUpFormBloc signUpFormBloc = SignUpFormBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final List<String> items = [
    'Male',
    'Female',
    'Other',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      bloc: signUpFormBloc,
      listenWhen: (previous, current) => current is SignUpFormActionState,
      buildWhen: (previous, current) => current is! SignUpFormActionState,
      listener: (context, state) {
        if (state is SignUpFormSubmitSuccessState) {
          context.go("/");
        } else if (state is SignUpFormSubmitErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something wrong!")));
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Center(
          child: Container(
              width: 50.w,
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Submit the form to continue",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("We will not share your information with anyone."),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "enter your full name",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _numberController,
                      decoration:
                          InputDecoration(hintText: "enter your phonr number"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        hintText: "Date of birth",
                      ),
                      onTap: () async {
                        DateTime? datePicker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now());
                        if (datePicker != null) {
                          var formatedDate =
                              DateFormat("yyyy-mm-dd").format(datePicker);
                          _dateController.text = formatedDate;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Select Gender',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.orange)),
                          onPressed: () {
                            signUpFormBloc.add(SignUpFormSubmitEvent(
                                name: _nameController.text.toString(),
                                birthDate: _dateController.text.toString(),
                                gender: selectedValue.toString(),
                                phoneNumber:
                                    _numberController.text.toString()));
                          },
                          child: Text("Submit")),
                    )
                  ])),
        ));
      },
    );
  }
}
