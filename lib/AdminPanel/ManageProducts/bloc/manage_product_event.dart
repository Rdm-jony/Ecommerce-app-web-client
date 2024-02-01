part of 'manage_product_bloc.dart';

@immutable
abstract class ManageProductEvent {}

class FatchProductInitialEEvent extends ManageProductEvent {}

class AddAdsProductEvent extends ManageProductEvent {
  final cartDetails;

  AddAdsProductEvent({required this.cartDetails});
}

class AddTopProductEvent extends ManageProductEvent {
  final cartDetails;

  AddTopProductEvent({required this.cartDetails});
}

class DeleteAdsProductEvent extends ManageProductEvent {
  final String cartId;

  DeleteAdsProductEvent({required this.cartId});
}

class DeleteTopProductEvent extends ManageProductEvent {
  final String cartId;

  DeleteTopProductEvent({required this.cartId});
}

class DeleteProductEvent extends ManageProductEvent {
  final String cartId;

  DeleteProductEvent({required this.cartId});

}
