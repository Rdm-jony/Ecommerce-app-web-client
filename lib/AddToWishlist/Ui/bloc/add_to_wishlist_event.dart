part of 'add_to_wishlist_bloc.dart';

@immutable
abstract class AddToWishlistEvent {}
class FatchInitialEvent extends AddToWishlistEvent{}
class CartDeleteEvent extends AddToWishlistEvent {
  final cartId;

  CartDeleteEvent({required this.cartId});
}

