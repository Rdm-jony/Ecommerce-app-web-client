import 'package:e_commerce_app_bloc/AllProducts/bloc/all_products_bloc.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TopProductTileWidegt extends StatelessWidget {
  final TopProductDataModel topProductDataModel;

  TopProductTileWidegt({super.key, required this.topProductDataModel});
  AllProductsBloc allProductsBloc = AllProductsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllProductsBloc, AllProductsState>(
      bloc: allProductsBloc,
      listenWhen: (previous, current) => current is AllProductsActionState,
      buildWhen: (previous, current) => current is! AllProductsActionState,
      listener: (context, state) {
        if (state is NavigateProductDetailsState) {
          if (kIsWeb) {
            context.go("/productDetails", extra: state.productDetails);
          } else {
            Navigator.pushNamed(context, "productDetails_pg",
                arguments: state.productDetails);
          }
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return InkWell(
          onTap: () => allProductsBloc.add(
              NavigateProductDetailsEvent(productDetails: topProductDataModel)),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(5),
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.5)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                              topProductDataModel.image.toString())),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${topProductDataModel.title!.length>20?topProductDataModel.title?.substring(0, 20):topProductDataModel.title}....",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Price: \$${topProductDataModel.price}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border_outlined)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.shopping_cart_checkout_outlined))
                      ],
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
