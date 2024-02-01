import 'package:e_commerce_app_bloc/Home/Widgets/AdsProduct/bloc/ads_product_bloc.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Ui/Top_product_tile_widget.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/bloc/top_product_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AdsProducts extends StatefulWidget {
  AdsProducts({super.key});

  @override
  State<AdsProducts> createState() => _AdsProductsState();
}

class _AdsProductsState extends State<AdsProducts> {
  final AdsProductBloc adsProductBloc = AdsProductBloc();

  @override
  void initState() {
    super.initState();
    adsProductBloc.add(AdsProductInitialFatchEvent());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: BlocConsumer<AdsProductBloc, AdsProductState>(
        bloc: adsProductBloc,
        listenWhen: (previous, current) => current is AdsProductActionState,
        buildWhen: (previous, current) => current is! AdsProductActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AdsProductFatchLoadingState:
              return const Center(child: CircularProgressIndicator());
            case AdsProductFatchSuccessState:
              final successState = state as AdsProductFatchSuccessState;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: successState.adsProducts.length,
                itemBuilder: (context, index) => TopProductTileWidegt(
                    topProductDataModel: successState.adsProducts[index]),
              );
            default:
          }
          return Container();
        },
      ),
    );
  }
}
