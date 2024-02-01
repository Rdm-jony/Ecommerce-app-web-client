part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

abstract class SignInActionState extends SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccessState extends SignInActionState {}

class SignInErrorState extends SignInActionState {
  final error;

  SignInErrorState({required this.error});
}

class SignInToSignUpState extends SignInActionState{}
