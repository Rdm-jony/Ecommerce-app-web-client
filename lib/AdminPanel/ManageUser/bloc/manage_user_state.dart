part of 'manage_user_bloc.dart';

@immutable
abstract class ManageUserState {}

abstract class ManageUserActionState extends ManageUserState {}

class ManageUserInitial extends ManageUserState {}

class FatchAllUsersLodingState extends ManageUserState {}

class FatchAllUsersSuccessState extends ManageUserState {
  final List allUsers;

  FatchAllUsersSuccessState({required this.allUsers});
}
