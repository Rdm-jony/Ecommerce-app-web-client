import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/Repo/Admin_repo.dart';
import 'package:e_commerce_app_bloc/AllProducts/Ui/All_product_tile_widget.dart';
import 'package:e_commerce_app_bloc/AllProducts/Widget/Search_bar._widget.dart';
import 'package:e_commerce_app_bloc/AllProducts/bloc/all_products_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Home/Widgets/Top_products/bloc/top_product_bloc.dart';

class AllProducts extends StatefulWidget {
  AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final _advancedDrawerController = AdvancedDrawerController();
  bool isAdmin = false;

  final AllProductsBloc allProductsBloc = AllProductsBloc();
  List searchProducts = [];
  callback(searchProductsFunction) {
    searchProducts = searchProductsFunction;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // allProductsBloc.add(CategoryFatchEvent());
    if (isAdmin == false) {
      AdminRepo.isAdmin().then((value) {
        setState(() {
          isAdmin = value;
        });
      });
    }
    allProductsBloc.add(FatchInitialProductsEvent());
  }

  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade50, Colors.orange.withOpacity(0.5)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: kIsWeb?
            isAdmin
                ? AdaptiveNavBar(
                    leading: IconButton(
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? Icons.clear : Icons.menu,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),
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
                    leading: IconButton(
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? Icons.clear : Icons.menu,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),
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
                      ])
            : AppBar(
                leading: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
              ),
        body: BlocConsumer<AllProductsBloc, AllProductsState>(
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
            switch (state.runtimeType) {
              case FatchAllProductsLoadingState:
                // allProductsBloc.add(CategoryFatchEvent());
                return const Center(child: CircularProgressIndicator());
              case FatchAllProductsSuccessState:
                final successState = state as FatchAllProductsSuccessState;

                return Column(
                  children: [
                    SizedBox(
                        width: double.maxFinite,
                        height: 50,
                        child: SearchBar(
                          callbackFunction: callback,
                        )),
                    searchProducts.length > 0
                        ? SizedBox(
                            width: double.maxFinite,
                            height: 150,
                            child: ListView.builder(
                              itemCount: searchProducts.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    allProductsBloc.add(
                                        NavigateProductDetailsEvent(
                                            productDetails: successState
                                                .allProducts[index]));
                                  },
                                  shape: Border.all(width: 1),
                                  leading: Image.network(
                                    searchProducts[index].image,
                                    height: 50,
                                  ),
                                  title: Text(
                                      "${searchProducts[index].title.toString().substring(0, 20)}...."),
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: successState.allProducts.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2 / 3.2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemBuilder: (context, index) => AllProductTileWidegt(
                          topProductDataModel: successState.allProducts[index],
                          allProductsBloc: allProductsBloc,
                        ),
                      ),
                    ),
                  ],
                );
              default:
            }
            return Container();
          },
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.black,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                ListTile(
                  title: Text("All"),
                  onTap: () {
                    allProductsBloc.add(FatchInitialProductsEvent());
                  },
                ),
                ListTile(
                  title: Text("Electronics"),
                  onTap: () => allProductsBloc.add(
                      CategoryProductsFatchEvent(categoryName: "electronics")),
                ),
                ListTile(
                  title: Text("Jewelery"),
                  onTap: () => allProductsBloc.add(
                      CategoryProductsFatchEvent(categoryName: "jewelery")),
                ),
                ListTile(
                  title: Text("Men's clothing"),
                  onTap: () => allProductsBloc.add(CategoryProductsFatchEvent(
                      categoryName: "men's clothing")),
                ),
                ListTile(
                  title: Text("Women's clothing"),
                  onTap: () => allProductsBloc.add(CategoryProductsFatchEvent(
                      categoryName: "women's clothing")),
                ),
                // SizedBox(
                //   height: 300,
                //   child: BlocConsumer<AllProductsBloc, AllProductsState>(
                //     bloc: allProductsBloc,
                //     listenWhen: (previous, current) =>
                //         current is AllProductsActionState,
                //     buildWhen: (previous, current) =>
                //         current is! AllProductsActionState,
                //     listener: (context, state) {
                //       // TODO: implement listener
                //     },
                //     builder: (context, state) {
                //       switch (state.runtimeType) {
                //         case CategoryFatchLoadingState:
                //           return const Center(
                //               child: CircularProgressIndicator());
                //         case CategoryFatchSuccesState:
                //           final successState =
                //               state as CategoryFatchSuccesState;

                //           return ListView.builder(
                //             itemCount: successState.categories.length,
                //             itemBuilder: (context, index) {
                //               return InkWell(
                //                 onTap: () {
                //                   allProductsBloc.add(
                //                       CategoryProductsFatchEvent(
                //                           categoryName:
                //                               successState.categories[index]));
                //                 },
                //                 child: Container(
                //                   margin: EdgeInsets.all(8),
                //                   decoration: BoxDecoration(
                //                       border: Border.all(width: 1)),
                //                   child: ListTile(
                //                     title: Center(
                //                         child: Text(
                //                       successState.categories[index],
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold),
                //                     )),
                //                   ),
                //                 ),
                //               );
                //             },
                //           );
                //         default:
                //       }
                //       return Container();
                //     },
                //   ),
                // ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
