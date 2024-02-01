part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}
class SignUpStateEvent extends SignUpEvent {
  final userEmail;
  final userPass;

  SignUpStateEvent({required this.userEmail, required this.userPass});
}

class SignUpToSignInEvent extends SignUpEvent{}