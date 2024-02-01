import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/AdsProduct/Repo/AdsProductRepo.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:meta/meta.dart';

part 'ads_product_event.dart';
part 'ads_product_state.dart';

class AdsProductBloc extends Bloc<AdsProductEvent, AdsProductState> {
  AdsProductBloc() : super(AdsProductInitial()) {
    on<AdsProductInitialFatchEvent>(adsProductInitialFatchEvent);
  }

  FutureOr<void> adsProductInitialFatchEvent(
      AdsProductInitialFatchEvent event, Emitter<AdsProductState> emit) async {
    emit(AdsProductFatchLoadingState());
    List<TopProductDataModel> adsProducts =
        await AdsProductsRepo.fatchAdsProducts();

    emit(AdsProductFatchSuccessState(adsProducts: adsProducts));
  }
}
