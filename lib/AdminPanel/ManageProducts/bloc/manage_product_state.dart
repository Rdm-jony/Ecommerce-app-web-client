part of 'manage_product_bloc.dart';

@immutable
abstract class ManageProductState {}

class ManageProductActionState extends ManageProductState {}

class ManageProductInitial extends ManageProductState {}

class FatchProductSuccessState extends ManageProductInitial {
  final List allProduct;

  FatchProductSuccessState({required this.allProduct});
}

class FatchProductLoadingState extends ManageProductInitial {}
class DeleteProductSuccessState extends ManageProductActionState{}


