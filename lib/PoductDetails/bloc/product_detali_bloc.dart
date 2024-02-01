import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/PoductDetails/Repo/ProductDetail_repo.dart';
import 'package:meta/meta.dart';

part 'product_detali_event.dart';
part 'product_detali_state.dart';

class ProductDetaliBloc extends Bloc<ProductDetaliEvent, ProductDetaliState> {
  ProductDetaliBloc() : super(ProductDetaliInitial()) {
    on<AddToCartEvent>(addToCartEvent);
    on<AddToWishListEvent>(addToWishListEvent);
  }

  FutureOr<void> addToCartEvent(
      AddToCartEvent event, Emitter<ProductDetaliState> emit) async {
    final status =
        await ProductsDetailRepo.addToCartFunction(event.cardDetails);

    emit(AddToCartSuccessState(status: status));
  }

  FutureOr<void> addToWishListEvent(
      AddToWishListEvent event, Emitter<ProductDetaliState> emit) async {
    final status =
        await ProductsDetailRepo.addToWishListFunction(event.cardDetail);

    emit(AddToWishlistSuccessState(status: status));
  }
}
