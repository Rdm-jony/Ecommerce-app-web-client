part of 'product_detali_bloc.dart';

@immutable
abstract class ProductDetaliEvent {}

class AddToCartEvent extends ProductDetaliEvent {
  final cardDetails;

  AddToCartEvent({required this.cardDetails});
}

class AddToWishListEvent extends ProductDetaliEvent {
  final cardDetail;

  AddToWishListEvent({required this.cardDetail});
}
