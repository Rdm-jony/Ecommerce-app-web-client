part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}
abstract class ProfileActionState extends ProfileState{}
class ProfileInitial extends ProfileState {}

class FatchProfileLoadingState extends ProfileState{}
class FatchProfileSuccessState extends ProfileState{
   final profileData;

  FatchProfileSuccessState({required this.profileData});

}
