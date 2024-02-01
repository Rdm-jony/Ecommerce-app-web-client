import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:e_commerce_app_bloc/AdminPanel/AddProducts/Ui/AddProductScreen.dart';
import 'package:e_commerce_app_bloc/AdminPanel/ManageProducts/Ui/ManageProduct_screen.dart';
import 'package:e_commerce_app_bloc/AdminPanel/ManageUser/Ui/ManageUser_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List allPage = [AddProducts(), ManageProduct(), ManageUser()];

  var index = 0;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: kIsWeb
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
          : AppBar(
              title: Text("Admin Dashboard"),
            ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Add Products',
            route: '/dashboard/addProucts',
            icon: Icons.toys,
          ),
          AdminMenuItem(
            title: 'Manage Products',
            route: '/dashboard/manageProduct',
            icon: Icons.toys,
          ),
          AdminMenuItem(
            title: 'Manage User',
            route: '/dashboard/manageUser',
            icon: Icons.person_2,
          ),
        ],
        selectedRoute: '/dashboard/addProucts',
        onSelected: (item) {
          if (item.route != null) {
            if (item.route == "/dashboard/addProucts") {
              setState(() {
                index = 0;
              });
              if (kIsWeb) {
                context.go(item.route.toString());
              }
            } else if (item.route == "/dashboard/manageProduct") {
              index = 1;
              setState(() {});
              if (kIsWeb) {
                context.go(item.route.toString());
              }
            } else if (item.route == "/dashboard/manageUser") {
              setState(() {
                index = 2;
              });
              if (kIsWeb) {
                context.go(item.route.toString());
              }
            }
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: allPage[index],
    );
  }
}
