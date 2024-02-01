import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen.dart';
import 'package:e_commerce_app_bloc/AddToWishlist/Ui/AddToWishlist_Screen.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Ui/DashBoard_Screen.dart';
import 'package:e_commerce_app_bloc/Favourites/Ui/Favourites_screen.dart';
import 'package:e_commerce_app_bloc/Home/Ui/Home_screen.dart';
import 'package:e_commerce_app_bloc/Profile/Ui/Profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BottomNavAdmin extends StatefulWidget {
  const BottomNavAdmin({super.key});

  @override
  State<BottomNavAdmin> createState() => _BottomNavAdminState();
}

class _BottomNavAdminState extends State<BottomNavAdmin> {
  int _currentIndex = 0;
  final List tabs = [
    Home(),
    AddToWishlist(),
    AddToCart(),
    Profile(),
    Dashboard()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.orange.shade100,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Wishlist",
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: "Cartlist",
            icon: Icon(Icons.shopping_cart_checkout_outlined),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(Icons.dashboard),
          ),
        ],
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
