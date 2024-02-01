part of 'product_detali_bloc.dart';

@immutable
abstract class ProductDetaliState {}

abstract class ProductDetaliActionState extends ProductDetaliState {}

class ProductDetaliInitial extends ProductDetaliState {}

class AddToCartSuccessState extends ProductDetaliActionState {
  final status;

  AddToCartSuccessState({required this.status});
}

class AddToWishlistSuccessState extends ProductDetaliActionState {
  final status;

  AddToWishlistSuccessState({required this.status});
}
