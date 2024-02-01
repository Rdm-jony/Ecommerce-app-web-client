part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

abstract class SignUpActionState extends SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccessState extends SignUpActionState {}

class SignUpErrorState extends SignUpActionState {
  final error;

  SignUpErrorState({required this.error});
}

class SignUpToSignInState extends SignUpActionState{}