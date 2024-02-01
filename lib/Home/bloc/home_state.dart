part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
abstract class HomeActioState extends HomeState{}

class HomeInitial extends HomeState {}

class HomeToAllproductsNavigateState extends HomeActioState{}
