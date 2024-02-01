part of 'all_products_bloc.dart';

@immutable
abstract class AllProductsEvent {}

class FatchInitialProductsEvent extends AllProductsEvent {}

class CategoryProductsFatchEvent extends AllProductsEvent {
  final String categoryName;

  CategoryProductsFatchEvent({required this.categoryName});
}

class CategoryFatchEvent extends AllProductsEvent {}

class SearchItemEvent extends AllProductsEvent {
  final String searchText;

  SearchItemEvent({required this.searchText});
}

class NavigateProductDetailsEvent extends AllProductsEvent {
  final productDetails;
  

  NavigateProductDetailsEvent( {required this.productDetails});
}
