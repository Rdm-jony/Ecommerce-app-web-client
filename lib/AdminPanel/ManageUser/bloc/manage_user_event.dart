part of 'manage_user_bloc.dart';

@immutable
abstract class ManageUserEvent {}

class FatchAllUsersEvent extends ManageUserEvent {}

class UserToAdminEvent extends ManageUserEvent {
  final String email;
  final String role;

  UserToAdminEvent({required this.email, required this.role});
}
