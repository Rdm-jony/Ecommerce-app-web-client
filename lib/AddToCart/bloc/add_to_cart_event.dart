part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartEvent {}

class FatchInitialCart extends AddToCartEvent {}

class CartDeleteEvent extends AddToCartEvent {
  final cartId;

  CartDeleteEvent({required this.cartId});
}

class CartPaymentEvent extends AddToCartEvent {
  final cartDetails;

  CartPaymentEvent({required this.cartDetails});
}

class SendPaidStatusEvent extends AddToCartEvent {
  final cartId;

  SendPaidStatusEvent({required this.cartId});

}
