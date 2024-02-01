import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repo/Sign_up_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpStateEvent>(signUpStateEvent);
    on<SignUpToSignInEvent>(signUpToSignInEvent);
  }

  FutureOr<void> signUpStateEvent(
      SignUpStateEvent event, Emitter<SignUpState> emit) async {
    final status =
        await SignUpRepo.SignUpWithEmail(event.userEmail, event.userPass);
    if (status == "true") {
      return emit(SignUpSuccessState());
    }

    emit(SignUpErrorState(error: status));
  }

  FutureOr<void> signUpToSignInEvent(
      SignUpToSignInEvent event, Emitter<SignUpState> emit) {
    emit(SignUpToSignInState());
  }
}
