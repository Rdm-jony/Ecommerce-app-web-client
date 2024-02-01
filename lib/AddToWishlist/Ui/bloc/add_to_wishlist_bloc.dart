import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/Repo/AddToWishlist_repo.dart';
import 'package:meta/meta.dart';

part 'add_to_wishlist_event.dart';
part 'add_to_wishlist_state.dart';

class AddToWishlistBloc extends Bloc<AddToWishlistEvent, AddToWishlistState> {
  AddToWishlistBloc() : super(AddToWishlistInitial()) {
    on<FatchInitialEvent>(fatchInitialEvent);
    on<CartDeleteEvent>(cartDeleteEvent);
  }

  FutureOr<void> fatchInitialEvent(
      FatchInitialEvent event, Emitter<AddToWishlistState> emit) async {
    emit(FatchInitialLoadingState());
    List cartItems = await AddToWishlistRepo.fatchInitialCarts();
    emit(FatchInitialSuccessState(allCarts: cartItems));
  }

  FutureOr<void> cartDeleteEvent(
      CartDeleteEvent event, Emitter<AddToWishlistState> emit) async {
    bool isDeleted = await AddToWishlistRepo.deleteCartFunction(event.cartId);
    print(isDeleted);
    if (isDeleted == true) {
      List cartItems = await AddToWishlistRepo.fatchInitialCarts();
      emit(FatchInitialSuccessState(allCarts: cartItems));
    }
  }
}
