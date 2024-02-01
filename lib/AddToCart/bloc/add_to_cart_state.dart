part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartState {}

abstract class AddToCartActonState extends AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class FatchInitialLoadingState extends AddToCartState {}

class FatchInitialSuccessState extends AddToCartState {
  final List allCarts;

  FatchInitialSuccessState({required this.allCarts});
}

class PaymentSuccessState extends AddToCartActonState {
  final session;

  PaymentSuccessState({required this.session});
}
