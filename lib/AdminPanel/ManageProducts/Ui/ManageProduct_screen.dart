import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:e_commerce_app_bloc/AdminPanel/ManageProducts/bloc/manage_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({super.key});

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  ManageProductBloc manageProductBloc = ManageProductBloc();

  @override
  void initState() {
    // TODO: implement initState
    manageProductBloc.add(FatchProductInitialEEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ManageProductBloc, ManageProductState>(
        bloc: manageProductBloc,
        listenWhen: (previous, current) => current is ManageProductActionState,
        buildWhen: (previous, current) => current is! ManageProductActionState,
        listener: (context, state) {
          if (state is DeleteProductSuccessState) {
            Navigator.pop(context);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchProductLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FatchProductSuccessState:
              final success = state as FatchProductSuccessState;
              return ListView.builder(
                itemCount: success.allProduct.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.square(
                            dimension: 50,
                            child: Image.network(
                                success.allProduct[index].image,
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${success.allProduct[index].title!.length > 20 ? success.allProduct[index].title.toString().substring(0, 20) : success.allProduct[index].title}...",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("\$${success.allProduct[index].price}"),
                          SizedBox(
                            width: 8,
                          ),
                          success.allProduct[index].ads == true
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    manageProductBloc.add(DeleteAdsProductEvent(
                                        cartId: success.allProduct[index].sId));
                                  },
                                  child: const Text(
                                    "Undo Ads",
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink),
                                  onPressed: () {
                                    manageProductBloc.add(AddAdsProductEvent(
                                        cartDetails:
                                            success.allProduct[index]));
                                  },
                                  child: const Text(
                                    "Ads",
                                    style: TextStyle(color: Colors.white),
                                  )),
                          SizedBox(
                            width: 8,
                          ),
                          success.allProduct[index].top == true
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    manageProductBloc.add(DeleteTopProductEvent(
                                        cartId: success.allProduct[index].sId));
                                  },
                                  child: const Text(
                                    "Undo Top",
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent),
                                  onPressed: () {
                                    manageProductBloc.add(AddTopProductEvent(
                                        cartDetails:
                                            success.allProduct[index]));
                                  },
                                  child: const Text(
                                    "Top",
                                    style: TextStyle(color: Colors.white),
                                  )),
                          SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Are you sure too delete this Product?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("No")),
                                        TextButton(
                                            onPressed: () {
                                              manageProductBloc.add(
                                                  DeleteProductEvent(
                                                      cartId: success
                                                          .allProduct[index]
                                                          .sId));
                                            },
                                            child: Text("Yes"))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
            default:
          }
          return Container();
        },
      ),
    );
  }
}
