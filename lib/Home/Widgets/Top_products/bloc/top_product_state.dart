part of 'top_product_bloc.dart';

@immutable
abstract class TopProductState {}

abstract class TopProductActionState extends TopProductState {}

class TopProductInitial extends TopProductState {}

class TopProductFatchSuccessState extends TopProductState {
  final List<TopProductDataModel> topProducts;

  TopProductFatchSuccessState({required this.topProducts});
}

class TopProductFatchLoadingState extends TopProductState{}
class TopProductFatchErrorState extends TopProductState{}
