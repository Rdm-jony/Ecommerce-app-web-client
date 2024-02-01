import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/AdminPanel/ManageProducts/Repo/ManageProduct_repo.dart';
import 'package:e_commerce_app_bloc/AllProducts/Repo/All_products_repo.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:meta/meta.dart';

part 'manage_product_event.dart';
part 'manage_product_state.dart';

class ManageProductBloc extends Bloc<ManageProductEvent, ManageProductState> {
  ManageProductBloc() : super(ManageProductInitial()) {
    on<FatchProductInitialEEvent>(fatchProductInitialEEvent);
    on<AddAdsProductEvent>(addAdsProductEvent);
    on<DeleteAdsProductEvent>(deleteAdsProductEvent);
    on<AddTopProductEvent>(addTopProductEvent);
    on<DeleteTopProductEvent>(deleteTopProductEvent);
    on<DeleteProductEvent>(deleteProductEvent);
  }

  FutureOr<void> fatchProductInitialEEvent(
      FatchProductInitialEEvent event, Emitter<ManageProductState> emit) async {
    emit(FatchProductLoadingState());
    final allProduct = await AllProsucts.fatchAllProducts();
    emit(FatchProductSuccessState(allProduct: allProduct));
  }

  FutureOr<void> addAdsProductEvent(
      AddAdsProductEvent event, Emitter<ManageProductState> emit) async {
    bool isInsert = await ManageProductRepo.adsProductInsert(event.cartDetails);
    if (isInsert) {
      final allProduct = await AllProsucts.fatchAllProducts();
      emit(FatchProductSuccessState(allProduct: allProduct));
    }
  }

  FutureOr<void> deleteAdsProductEvent(
      DeleteAdsProductEvent event, Emitter<ManageProductState> emit) async {
    bool isDelete = await ManageProductRepo.adsProductDelete(event.cartId);
    if (isDelete) {
      final allProduct = await AllProsucts.fatchAllProducts();
      emit(FatchProductSuccessState(allProduct: allProduct));
    }
  }

  FutureOr<void> addTopProductEvent(
      AddTopProductEvent event, Emitter<ManageProductState> emit) async {
    bool isInsert = await ManageProductRepo.topProductInsert(event.cartDetails);
    if (isInsert) {
      final allProduct = await AllProsucts.fatchAllProducts();
      emit(FatchProductSuccessState(allProduct: allProduct));
    }
  }

  FutureOr<void> deleteTopProductEvent(
      DeleteTopProductEvent event, Emitter<ManageProductState> emit) async {
    bool isDelete = await ManageProductRepo.topProductDelete(event.cartId);
    if (isDelete) {
      final allProduct = await AllProsucts.fatchAllProducts();
      emit(FatchProductSuccessState(allProduct: allProduct));
    }
  }

  FutureOr<void> deleteProductEvent(
      DeleteProductEvent event, Emitter<ManageProductState> emit) async {
    bool isDelete = await ManageProductRepo.deleteProduct(event.cartId);
    if (isDelete) {
      final allProduct = await AllProsucts.fatchAllProducts();

      emit(FatchProductSuccessState(allProduct: allProduct));
      emit(DeleteProductSuccessState());
    }
  }
}
