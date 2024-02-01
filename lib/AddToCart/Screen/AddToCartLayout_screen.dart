import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen.dart';
import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddToCartLayout extends StatefulWidget {
  const AddToCartLayout({super.key});

  @override
  State<AddToCartLayout> createState() => _AddToCartLayoutState();
}

class _AddToCartLayoutState extends State<AddToCartLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.minWidth > 600) {
          return AddToCartWeb();
        }
        return AddToCart();
      },
    );
  }
}
