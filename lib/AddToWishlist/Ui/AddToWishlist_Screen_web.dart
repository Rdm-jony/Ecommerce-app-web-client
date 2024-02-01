import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/bloc/add_to_wishlist_bloc.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/Repo/Admin_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddToWishlistWeb extends StatefulWidget {
  const AddToWishlistWeb({super.key});

  @override
  State<AddToWishlistWeb> createState() => _AddToWishlistWebState();
}

class _AddToWishlistWebState extends State<AddToWishlistWeb> {
  AddToWishlistBloc addToWishlistBloc = AddToWishlistBloc();
  bool isAdmin = false;
  @override
  void initState() {
    // TODO: implement initState
    addToWishlistBloc.add(FatchInitialEvent());
    if (isAdmin == false) {
      AdminRepo.isAdmin().then((value) {
        setState(() {
          isAdmin = value;
        });
      });
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: isAdmin
          ? AdaptiveNavBar(
              automaticallyImplyLeading: false,
              screenWidth: sw,
              navBarItems: [
                  NavBarItem(
                    text: "Home",
                    onTap: () {
                      context.go("/");
                    },
                  ),
                  NavBarItem(
                    text: "Products",
                    onTap: () {
                      context.go("/allProducts");
                    },
                  ),
                  NavBarItem(
                    text: "Favourites",
                    onTap: () {
                      context.go("/wishlist");
                    },
                  ),
                  NavBarItem(
                    text: "Add Cart",
                    onTap: () {
                      context.go("/addToCart");
                    },
                  ),
                  NavBarItem(
                    text: "Proflie",
                    onTap: () {
                      context.go("/profile");
                    },
                  ),
                  NavBarItem(
                    text: "Dashboard",
                    onTap: () {
                      context.go("/dashboard");
                    },
                  )
                ])
          : AdaptiveNavBar(
              automaticallyImplyLeading: false,
              screenWidth: sw,
              navBarItems: [
                  NavBarItem(
                    text: "Home",
                    onTap: () {
                      context.go("/");
                    },
                  ),
                  NavBarItem(
                    text: "Products",
                    onTap: () {
                      context.go("/allProducts");
                    },
                  ),
                  NavBarItem(
                    text: "Favourites",
                    onTap: () {
                      context.go("/wishlist");
                    },
                  ),
                  NavBarItem(
                    text: "Add Cart",
                    onTap: () {
                      context.go("/addToCart");
                    },
                  ),
                  NavBarItem(
                    text: "Proflie",
                    onTap: () {
                      context.go("/profile");
                    },
                  ),
                ]),
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
                            "${success.allCarts[index].title!.length>20?success.allCarts[index].title.substring(0, 20):success.allCarts[index].title}....",
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
                                    cartId: success.allCarts[index].sId
                                        .toString()));
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
