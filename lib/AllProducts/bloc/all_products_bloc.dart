import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/AllProducts/Repo/All_products_repo.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:meta/meta.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsInitial()) {
    on<FatchInitialProductsEvent>(fatchInitialProductsEvent);
    on<CategoryProductsFatchEvent>(categoryProductsFatchEvent);
    on<SearchItemEvent>(searchItemEvent);
    on<NavigateProductDetailsEvent>(navigateProductDetailsEvent);
  }

  FutureOr<void> fatchInitialProductsEvent(
      FatchInitialProductsEvent event, Emitter<AllProductsState> emit) async {
    emit(FatchAllProductsLoadingState());
    final allProducts = await AllProsucts.fatchAllProducts();
    emit(FatchAllProductsSuccessState(allProducts: allProducts));
  }

  FutureOr<void> categoryProductsFatchEvent(
      CategoryProductsFatchEvent event, Emitter<AllProductsState> emit) async {
    emit(FatchAllProductsLoadingState());
    final allProducts =
        await AllProsucts.fatchAllCategoryProducts(event.categoryName);
    emit(FatchAllProductsSuccessState(allProducts: allProducts));
  }

  FutureOr<void> searchItemEvent(
      SearchItemEvent event, Emitter<AllProductsState> emit) async {
    final List searchItems = await SearchItem.fatchSearchItem(event.searchText);

    emit(FatchSearchItemSuccessState(searchItems: searchItems));
  }

  FutureOr<void> navigateProductDetailsEvent(
      NavigateProductDetailsEvent event, Emitter<AllProductsState> emit) {
    
    emit(NavigateProductDetailsState(productDetails: event.productDetails));
  }
}
