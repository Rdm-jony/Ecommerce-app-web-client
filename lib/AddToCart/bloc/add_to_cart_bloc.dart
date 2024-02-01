import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/AddToCart/Repo/AddToCart_repo.dart';
import 'package:meta/meta.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  AddToCartBloc() : super(AddToCartInitial()) {
    on<FatchInitialCart>(fatchInitialCart);
    on<CartDeleteEvent>(cartDeleteEvent);
    on<CartPaymentEvent>(cartPaymentEvent);
    on<SendPaidStatusEvent>(sendPaidStatusEvent);
  }

  FutureOr<void> fatchInitialCart(
      FatchInitialCart event, Emitter<AddToCartState> emit) async {
    emit(FatchInitialLoadingState());
    List cartItems = await AddToCartRepo.fatchInitialCarts();
    emit(FatchInitialSuccessState(allCarts: cartItems));
  }

  FutureOr<void> cartDeleteEvent(
      CartDeleteEvent event, Emitter<AddToCartState> emit) async {
    bool isTrue = await AddToCartRepo.deleteCartFunction(event.cartId);
    if (isTrue) {
      List cartItems = await AddToCartRepo.fatchInitialCarts();
      emit(FatchInitialSuccessState(allCarts: cartItems));
    }
  }

  FutureOr<void> cartPaymentEvent(
      CartPaymentEvent event, Emitter<AddToCartState> emit) async {
    // print(event.cartDetails);

    final session = await AddToCartRepo.cartPayment(event.cartDetails);
    emit(PaymentSuccessState(session: session));
  }

  FutureOr<void> sendPaidStatusEvent(
      SendPaidStatusEvent event, Emitter<AddToCartState> emit) async {
    final isUpdate = await AddToCartRepo.updateCartPayment(event.cartId);
  }
}
