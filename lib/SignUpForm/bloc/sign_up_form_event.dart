part of 'sign_up_form_bloc.dart';

@immutable
abstract class SignUpFormEvent {}

class SignUpFormSubmitEvent extends SignUpFormEvent {
  final String name;
  final String phoneNumber;
  final String birthDate;
  final String gender;

  SignUpFormSubmitEvent(
      {required this.name,
      required this.phoneNumber,
      required this.birthDate,
      required this.gender});
}
