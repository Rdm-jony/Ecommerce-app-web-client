part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}
abstract class AdminActionState extends AdminState{}

class AdminInitial extends AdminState {}

class IsAdminState extends AdminState{}
