import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen.dart';
import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen_web.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/AddToWishlist_Screen.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/AddToWishlist_Screen_web.dart';
import 'package:e_commerce_app_bloc/AllProducts/Ui/All_products.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:e_commerce_app_bloc/PoductDetails/bloc/product_detali_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsWeb extends StatelessWidget {
  ProductDetailsWeb({super.key, required this.routeArgument});
  final routeArgument;
  ProductDetaliBloc productDetaliBloc = ProductDetaliBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductDetaliBloc, ProductDetaliState>(
        bloc: productDetaliBloc,
        listenWhen: (previous, current) => current is ProductDetaliActionState,
        buildWhen: (previous, current) => current is! ProductDetaliActionState,
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            if (state.status["msg"] == "Already Exist!") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.status["msg"])));
            } else if (state.status["modifiedCount"] == 1) {
              context.go("/addToCart");
            } else if (state.status["insertedId"] != null) {
              context.go("/addToCart");
            }
          } else if (state is AddToWishlistSuccessState) {
            if (state.status["msg"] == "Already Exist!") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.status["msg"])));
            } else if (state.status["modifiedCount"] == 1) {
              context.go("/wishlist");
            } else if (state.status["insertedId"] != null) {
              context.go("/wishlist");
            }
          }

          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.orange,
                ),
              ),
              width: 100.w,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      routeArgument?.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            routeArgument?.title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            routeArgument?.description,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Category: ${routeArgument?.category}",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "\$${routeArgument?.price}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () {
                                    productDetaliBloc.add(AddToWishListEvent(
                                        cardDetail: routeArgument));
                                  },
                                  icon: Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "AddToWishlist",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    productDetaliBloc.add(AddToCartEvent(
                                        cardDetails: routeArgument));
                                  },
                                  icon: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "AddToCart",
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
