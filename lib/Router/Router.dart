import 'dart:convert';

import 'package:e_commerce_app_bloc/AddToCart/Screen/AddToCartLayout_screen.dart';
import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen.dart';
import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen_web.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/AddToWishlist_Screen_web.dart';
import 'package:e_commerce_app_bloc/AdminPanel/AddProducts/Ui/AddProductScreen.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/AdminError_screen.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/Repo/Admin_repo.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Ui/DashBoard_Screen.dart';
import 'package:e_commerce_app_bloc/AllProducts/Ui/All_products.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_in/Screen/Layout_screen.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_in/Ui/Sign_in_screen_web.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_up/ui/Sign_up_screen_web.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Screen/NavbarLayout_screen.dart';
import 'package:e_commerce_app_bloc/Home/Ui/Home_screen_web.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:e_commerce_app_bloc/PoductDetails/Ui/ProductDetails_screen.dart';
import 'package:e_commerce_app_bloc/PoductDetails/Ui/ProductDetails_screen_web.dart';
import 'package:e_commerce_app_bloc/Profile/Ui/Profile_screen.dart';
import 'package:e_commerce_app_bloc/Profile/Ui/Profile_screen_web.dart';
import 'package:e_commerce_app_bloc/Router/currentUser.dart';
import 'package:e_commerce_app_bloc/SignUpForm/Ui/SignUp_form_screen_web.dart';
import 'package:e_commerce_app_bloc/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppRoute {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        pageBuilder: (context, state) => MaterialPage(child: NavbarLayout()),
        routes: [
          GoRoute(
            name: "allProducts",
            path: "allProducts",
            pageBuilder: (context, state) => MaterialPage(child: AllProducts()),
          ),
          GoRoute(
            name: "signIn",
            path: "signIn",
            pageBuilder: (context, state) => MaterialPage(child: SigninWeb()),
          ),
          GoRoute(
            name: "signUp",
            path: "signUp",
            pageBuilder: (context, state) => MaterialPage(child: SignUpWeb()),
          ),
          GoRoute(
            name: "signUpForm",
            path: "signUpForm",
            pageBuilder: (context, state) =>
                MaterialPage(child: SignUpFormWeb()),
          ),
          GoRoute(
            name: "wishlist",
            path: "wishlist",
            pageBuilder: (context, state) =>
                MaterialPage(child: AddToWishlistWeb()),
          ),
          GoRoute(
            name: "addToCart",
            path: "addToCart",
            pageBuilder: (context, state) =>
                MaterialPage(child: AddToCartLayout()),
          ),
          GoRoute(
            name: "profile",
            path: "profile",
            pageBuilder: (context, state) => MaterialPage(child: ProfileWeb()),
          ),
          GoRoute(
            name: "adminErrorPage",
            path: "adminErrorPage",
            pageBuilder: (context, state) =>
                MaterialPage(child: AdminErrorPage()),
          ),
          GoRoute(
              name: "dashboard",
              path: "dashboard",
              pageBuilder: (context, state) => MaterialPage(child: Dashboard()),
              routes: [
                GoRoute(
                  name: "addProucts",
                  path: "addProucts",
                  pageBuilder: (context, state) =>
                      MaterialPage(child: Dashboard()),
                ),
                GoRoute(
                  name: "manageUser",
                  path: "manageUser",
                  pageBuilder: (context, state) =>
                      MaterialPage(child: Dashboard()),
                ),
                GoRoute(
                  name: "manageProduct",
                  path: "manageProduct",
                  pageBuilder: (context, state) =>
                      MaterialPage(child: Dashboard()),
                ),
              ]),
          GoRoute(
              name: "productDetails",
              path: "productDetails",
              builder: (BuildContext context, GoRouterState state) {
                TopProductDataModel routeArgument =
                    state.extra! as TopProductDataModel;
                return ProductDetailsWeb(
                  routeArgument: routeArgument,
                );
              }),
        ],
      ),
    ],
    redirect: (context, state) async {
      bool isAuth = CurrentUser.getCurrentUser();
      bool isAdmin = await CurrentUser.isAdmin();
      if (!isAuth && state.location.startsWith("/")) {
        return "/signIn";
      }

      if (!isAdmin && state.location.startsWith("/dashboard")) {
        print(state.location);
        return "/adminErrorPage";
      }
      return null;
    },
  );
}
