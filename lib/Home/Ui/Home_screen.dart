import 'package:e_commerce_app_bloc/AllProducts/Ui/All_products.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/AdsProduct/Ui/AdsProducts_screen.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Banner_widget/Ui/Banner_widget.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Ui/Top_products.dart';
import 'package:e_commerce_app_bloc/Home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/Banner_widget/Ui/Banner_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homebloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActioState,
      buildWhen: (previous, current) => current is! HomeActioState,
      listener: (context, state) {
        if (state is HomeToAllproductsNavigateState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllProducts(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.orange.shade50,
          appBar: AppBar(
            backgroundColor: Colors.orange.shade50,
            title: Center(
              child: Text(
                "E-commerce",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                width: double.maxFinite,
                height: 200,
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
                    onTap: () => homebloc.add(HomeToAllproductsNavigateEvent()),
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
                height: 280,
                child: TopProducts(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Advertisment Products:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.orange),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 280,
                child: AdsProducts(),
              )
            ]),
          ),
        );
      },
    );
  }
}
