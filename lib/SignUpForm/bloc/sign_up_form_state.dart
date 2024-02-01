part of 'sign_up_form_bloc.dart';

@immutable
abstract class SignUpFormState {}

abstract class SignUpFormActionState extends SignUpFormState {}

class SignUpFormInitial extends SignUpFormState {}

class SignUpFormSubmitSuccessState extends SignUpFormActionState {}

class SignUpFormSubmitErrorState extends SignUpFormActionState{}
