part of 'add_product_bloc.dart';

@immutable
abstract class AddProductState {}

abstract class AddProductActionState extends AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductDataSuccessState extends AddProductActionState {
  final bool isSubmit;

  AddProductDataSuccessState({required this.isSubmit});
}
