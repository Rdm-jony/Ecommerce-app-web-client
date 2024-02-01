import 'package:e_commerce_app_bloc/AllProducts/bloc/all_products_bloc.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AllProductTileWidegt extends StatelessWidget {
  final TopProductDataModel topProductDataModel;
  final AllProductsBloc allProductsBloc;
  const AllProductTileWidegt(
      {super.key,
      required this.topProductDataModel,
      required this.allProductsBloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => allProductsBloc.add(
        NavigateProductDetailsEvent(productDetails: topProductDataModel),
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 0.5)),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 100,
              child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(topProductDataModel.image.toString())),
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
          ],
        ),
      ),
    );
  }
}
