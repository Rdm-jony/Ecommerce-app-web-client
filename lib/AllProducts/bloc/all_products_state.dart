part of 'all_products_bloc.dart';

@immutable
abstract class AllProductsState {}

abstract class AllProductsActionState extends AllProductsState {}

class AllProductsInitial extends AllProductsState {}

class FatchAllProductsLoadingState extends AllProductsState {}

class FatchAllProductsSuccessState extends AllProductsState {
  final List<TopProductDataModel> allProducts;

  FatchAllProductsSuccessState({required this.allProducts});
}

class CategoryFatchSuccesState extends AllProductsState {
  final List categories;

  CategoryFatchSuccesState({required this.categories});
}

class CategoryFatchLoadingState extends AllProductsState {}

class FatchSearchItemSuccessState extends AllProductsState {
  final List searchItems;

  FatchSearchItemSuccessState({required this.searchItems});
}

class FatchSearchItemLoadingState extends AllProductsState {}

class NavigateProductDetailsState extends AllProductsActionState {
  final productDetails;


  NavigateProductDetailsState({required this.productDetails});
}
