import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Ui/Top_product_tile_widget.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/bloc/top_product_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/Top_products_data_model.dart';

class TopProducts extends StatefulWidget {
  TopProducts({super.key});

  @override
  State<TopProducts> createState() => _TopProductsState();
}

class _TopProductsState extends State<TopProducts> {
  final TopProductBloc topProductBloc = TopProductBloc();

  @override
  void initState() {
    super.initState();
    topProductBloc.add(TopProductInitialFatchEvent());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: BlocConsumer<TopProductBloc, TopProductState>(
        bloc: topProductBloc,
        listenWhen: (previous, current) => current is TopProductActionState,
        buildWhen: (previous, current) => current is! TopProductActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TopProductFatchLoadingState:
              return const Center(child: CircularProgressIndicator());
            case TopProductFatchSuccessState:
              final successState = state as TopProductFatchSuccessState;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: successState.topProducts.length,
                itemBuilder: (context, index) => TopProductTileWidegt(
                    topProductDataModel: successState.topProducts[index]),
              );
            default:
          }
          return Container();
        },
      ),
    );
  }
}
