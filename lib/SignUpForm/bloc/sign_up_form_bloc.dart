import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/SignUpForm/Repo/Sign_up_form_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc() : super(SignUpFormInitial()) {
    on<SignUpFormSubmitEvent>(signUpFormSubmitEvent);
  }

  FutureOr<void> signUpFormSubmitEvent(
      SignUpFormSubmitEvent event, Emitter<SignUpFormState> emit) async {
    final msg = await SignUpFormRepo.formDataSendDatabase(
        event.name, event.phoneNumber, event.birthDate, event.gender);
    if (msg == "true") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("KEYLOGIN", true);
      return emit(SignUpFormSubmitSuccessState());
    }

    emit(SignUpFormSubmitErrorState());
  }
}
