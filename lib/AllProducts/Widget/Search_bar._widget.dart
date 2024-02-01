import 'package:e_commerce_app_bloc/AllProducts/Repo/All_products_repo.dart';
import 'package:e_commerce_app_bloc/AllProducts/bloc/all_products_bloc.dart';
import 'package:e_commerce_app_bloc/Home/Widgets/Top_products/Model/Top_products_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchBar extends StatelessWidget {
  AllProductsBloc allProductsBloc = AllProductsBloc();

  final Function callbackFunction;

  SearchBar({super.key, required this.callbackFunction});

  void searchFuntion(e) async {
    List searchItems = await SearchItem.fatchSearchItem(e);
    callbackFunction(searchItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 50,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    onChanged: (e) {
                      searchFuntion(e);
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2))),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.orange),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          )),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
