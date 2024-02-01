import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/Repo/Admin_repo.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Ui/DashBoard_Screen.dart';
import 'package:e_commerce_app_bloc/AllProducts/Ui/All_products.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Screen/NavbarLayout_screen.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/AdsProduct/Ui/AdsProducts_screen.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Banner_widget/Ui/Banner_widget.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Ui/Top_products.dart';
import 'package:e_commerce_app_bloc/Home/bloc/home_bloc.dart';
import 'package:e_commerce_app_bloc/Router/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/Banner_widget/Ui/Banner_widget.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  final HomeBloc homebloc = HomeBloc();
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
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActioState,
      buildWhen: (previous, current) => current is! HomeActioState,
      listener: (context, state) {
        if (state is HomeToAllproductsNavigateState) {
          context.go("/allProducts");
        }
      },
      builder: (context, state) {
        final sw = MediaQuery.of(context).size.width;

        return Scaffold(
          appBar: isAdmin
              ? AdaptiveNavBar(
                  title: Text("Ecommerce Bloc"),
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
                  title: Text("Ecommerce Bloc"),
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
          backgroundColor: Colors.orange.shade50,
          body: Builder(builder: (context) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 80.h,
                  child: BannerWidget(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Products",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () =>
                          homebloc.add(HomeToAllproductsNavigateEvent()),
                      child: Row(
                        children: [
                          Text(
                            "View all products",
                            style: TextStyle(
                                color: Colors.orange,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.orange,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: TopProducts(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Advertisment Products",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: AdsProducts(),
                )
              ]),
            );
          }),
        );
      },
    );
  }
}
