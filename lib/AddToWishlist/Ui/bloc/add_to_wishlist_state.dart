part of 'add_to_wishlist_bloc.dart';

@immutable
abstract class AddToWishlistState {}
abstract class AddToWishlistActionState extends AddToWishlistState{}

class AddToWishlistInitial extends AddToWishlistState {}
class FatchInitialLoadingState extends AddToWishlistState {}
class FatchInitialSuccessState extends AddToWishlistState {
  final List allCarts;

  FatchInitialSuccessState({required this.allCarts});
}

