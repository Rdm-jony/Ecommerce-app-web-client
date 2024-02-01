import 'package:e_commerce_app_bloc/AddToWishlist/Ui/bloc/add_to_wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToWishlist extends StatefulWidget {
  const AddToWishlist({super.key});

  @override
  State<AddToWishlist> createState() => _AddToWishlistState();
}

class _AddToWishlistState extends State<AddToWishlist> {
  AddToWishlistBloc addToWishlistBloc = AddToWishlistBloc();

  @override
  void initState() {
    // TODO: implement initState
    addToWishlistBloc.add(FatchInitialEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add To Wishliat"),
      ),
      body: BlocConsumer<AddToWishlistBloc, AddToWishlistState>(
        bloc: addToWishlistBloc,
        listenWhen: (previous, current) => current is AddToWishlistActionState,
        buildWhen: (previous, current) => current is! AddToWishlistActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchInitialLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case FatchInitialSuccessState:
              final success = state as FatchInitialSuccessState;

              return ListView.builder(
                itemCount: success.allCarts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(success.allCarts[index].image),
                          ),
                          Text(
                            "${success.allCarts[index].title!.length>10?success.allCarts[index].title.substring(0, 10):success.allCarts[index].title}....",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${success.allCarts[index].price.toString()}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.shopping_bag_outlined)),
                          InkWell(
                              onTap: () {
                                addToWishlistBloc.add(CartDeleteEvent(
                                    cartId:
                                        success.allCarts[index].sId.toString()));
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
          return Column();
        },
      ),
    );
  }
}
