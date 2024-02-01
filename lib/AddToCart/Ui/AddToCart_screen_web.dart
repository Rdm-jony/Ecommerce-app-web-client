import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen.dart';
import 'package:e_commerce_app_bloc/AddToCart/bloc/add_to_cart_bloc.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/Repo/Admin_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

class AddToCartWeb extends StatefulWidget {
  AddToCartWeb({super.key});

  @override
  State<AddToCartWeb> createState() => _AddToCartWebState();
}

class _AddToCartWebState extends State<AddToCartWeb> {
  AddToCartBloc addToCartBloc = AddToCartBloc();
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    if (isAdmin == false) {
      AdminRepo.isAdmin().then((value) {
        setState(() {
          isAdmin = value;
        });
      });
    }
    addToCartBloc.add(FatchInitialCart());
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
      body: BlocConsumer<AddToCartBloc, AddToCartState>(
        bloc: addToCartBloc,
        listenWhen: (previous, current) => current is AddToCartActonState,
        buildWhen: (previous, current) => current is! AddToCartActonState,
        listener: (context, state) {
          // TODO: implement listener
          if (state is PaymentSuccessState) {
            if (state.session["id"] != null) {
              paymentIntend(state.session);
            }
          }
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
                  return Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            success.allCarts[index].paid == true
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    onPressed: () {},
                                    child: const Text(
                                      "paid",
                                      style: TextStyle(color: Colors.white),
                                    ))
                                : ElevatedButton(
                                    onPressed: () {
                                      addToCartBloc.add(CartPaymentEvent(
                                          cartDetails:
                                              success.allCarts[index]));
                                    },
                                    child: Text(
                                      "PAY",
                                      style: TextStyle(color: Colors.white),
                                    )),
                            IconButton(
                                onPressed: () {
                                  addToCartBloc.add(CartDeleteEvent(
                                      cartId: success.allCarts[index].sId
                                          .toString()));
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
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

  void paymentIntend(session) async {
    final response = await redirectToCheckout(
        context: context,
        sessionId: session["id"],
        canceledUrl: session["cancel_url"],
        successUrl: session["success_url"],
        publishableKey:
            "pk_test_51M8nsMJerXZOObUuFBFKUH9HHXiwp1k0OFoOc4JJte18Pjy8FoPjkuWEMlKYYMXTfSybAwAWoeFoPpNC8G2NY9Wd00zf8hXdym");

    if (response.toString() == "CheckoutResponse.redirected()") {
      addToCartBloc.add(SendPaidStatusEvent(cartId: session["productId"]));
    }
  }
}
