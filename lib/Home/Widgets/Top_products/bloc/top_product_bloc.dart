import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Repo/Top_products_repo.dart';
import 'package:meta/meta.dart';

part 'top_product_event.dart';
part 'top_product_state.dart';

class TopProductBloc extends Bloc<TopProductEvent, TopProductState> {
  TopProductBloc() : super(TopProductInitial()) {
    on<TopProductInitialFatchEvent>(topProductInitialFatchEvent);
  }

  FutureOr<void> topProductInitialFatchEvent(
      TopProductInitialFatchEvent event, Emitter<TopProductState> emit) async {
    emit(TopProductFatchLoadingState());
    List<TopProductDataModel> topProducts =
        await TopProductsRepo.fatchTopProducts();
   
    emit(TopProductFatchSuccessState(topProducts: topProducts));
   
  }
}
