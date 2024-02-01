part of 'add_product_bloc.dart';

@immutable
abstract class AddProductEvent {}

class AddProductDataEvent extends AddProductEvent {
  final formData;

  AddProductDataEvent({required this.formData});
}
