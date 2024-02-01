import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/AddToWishlist_Screen.dart';
import 'package:e_commerce_app_bloc/AllProducts/Ui/All_products.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:e_commerce_app_bloc/PoductDetails/bloc/product_detali_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key});
  var routeArgument;
  ProductDetaliBloc productDetaliBloc = ProductDetaliBloc();

  @override
  Widget build(BuildContext context) {
    routeArgument =
        ModalRoute.of(context)?.settings.arguments as TopProductDataModel;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AllProducts(),
                ));
          },
          child: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              productDetaliBloc
                  .add(AddToWishListEvent(cardDetail: routeArgument));
            },
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
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
               Navigator.of(context).pushNamed("addTocart");
            } else if (state.status["insertedId"] != null) {
               Navigator.of(context).pushNamed("addTocart");
            }
          } else if (state is AddToWishlistSuccessState) {
            if (state.status["msg"] == "Already Exist!") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.status["msg"])));
            } else if (state.status["modifiedCount"] == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToWishlist(),
                  ));
            } else if (state.status["insertedId"] != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToWishlist(),
                  ));
            }
          }

          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 200,
                  child: Image.network(
                    routeArgument.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routeArgument.title.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "\$${routeArgument.price.toString()}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      routeArgument.description.toString(),
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                )),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        productDetaliBloc
                            .add(AddToCartEvent(cardDetails: routeArgument));
                      },
                      child: Text(
                        "Add To CART",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
