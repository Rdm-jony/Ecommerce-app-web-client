import 'package:e_commerce_app_bloc/AddToWishlist/Ui/AddToWishlist_Screen.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/AddToWishlist_Screen_web.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class AddToWishlistLayout extends StatefulWidget {
  const AddToWishlistLayout({super.key});

  @override
  State<AddToWishlistLayout> createState() => _AddToWishlistLayoutState();
}

class _AddToWishlistLayoutState extends State<AddToWishlistLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return AddToWishlistWeb();
        }
        return AddToWishlist();
      },
    );
  }
}
