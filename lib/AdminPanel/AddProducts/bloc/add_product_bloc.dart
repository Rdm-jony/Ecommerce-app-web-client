import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/AdminPanel/AddProducts/Repo/AddProduct_repo.dart';
import 'package:meta/meta.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitial()) {
    on<AddProductDataEvent>(addProductDataEvent);
  }

  FutureOr<void> addProductDataEvent(
      AddProductDataEvent event, Emitter<AddProductState> emit) async {
    bool isSubmit = await AddProductRepo.addProductData(event.formData);

    emit(AddProductDataSuccessState(isSubmit: isSubmit));
  }
}
