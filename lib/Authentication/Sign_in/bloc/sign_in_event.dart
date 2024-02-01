part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInStateEvent extends SignInEvent {
  final userEmail;
  final userPass;

  SignInStateEvent({required this.userEmail, required this.userPass});
}


class SignInToSignUpEvent extends SignInEvent{}
