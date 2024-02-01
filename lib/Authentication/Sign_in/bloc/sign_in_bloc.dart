import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Repo/Sign_in_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInStateEvent>(signInStateEvent);
    on<SignInToSignUpEvent>(signInToSignUpEvent);
  }

  FutureOr<void> signInStateEvent(
      SignInStateEvent event, Emitter<SignInState> emit) async {
    final status =
        await SignInRepo.SignInWithEmail(event.userEmail, event.userPass);
    print(status);
    if (status == "true") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("KEYLOGIN", true);
      return emit(SignInSuccessState());
    }

    emit(SignInErrorState(error: status));
  }

  FutureOr<void> signInToSignUpEvent(
      SignInToSignUpEvent event, Emitter<SignInState> emit) {
    emit(SignInToSignUpState());
  }
}
