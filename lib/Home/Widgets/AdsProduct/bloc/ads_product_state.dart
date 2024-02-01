part of 'ads_product_bloc.dart';

@immutable
abstract class AdsProductState {}
abstract class AdsProductActionState extends AdsProductState{}
class AdsProductInitial extends AdsProductState {}

class AdsProductFatchSuccessState extends AdsProductState {
  final List<TopProductDataModel> adsProducts;

  AdsProductFatchSuccessState({required this.adsProducts});
}

class AdsProductFatchLoadingState extends AdsProductState{}