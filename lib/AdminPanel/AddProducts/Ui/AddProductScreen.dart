import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce_app_bloc/AdminPanel/AddProducts/Repo/AddProduct_repo.dart';
import 'package:e_commerce_app_bloc/AdminPanel/AddProducts/bloc/add_product_bloc.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Ui/DashBoard_Screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddProducts extends StatefulWidget {
  AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  AddProductBloc addProductBloc = AddProductBloc();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var _key = GlobalKey<FormState>();
  final List<String> categories = [
    'electronics',
    'jewelery',
    "men's clothing",
    "women's clothing"
  ];

  String? selectedCategories;
  var imageName;
  var imageInBytes;
  var imagePath;
  var imageUrl;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductBloc, AddProductState>(
      bloc: addProductBloc,
      listenWhen: (previous, current) => current is AddProductActionState,
      buildWhen: (previous, current) => current is! AddProductActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is AddProductDataSuccessState) {
          if (state.isSubmit == true) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("successfully product added!")));
            if (kIsWeb) {
              context.go("/dashboard");
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(" product is not added!")));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "product title is reuired";
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: "Enter product title:"),
                    ),
                    TextFormField(
                      controller: priceController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "product price is required";
                        } else if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                          return "Please enter any number";
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: "Enter product price:"),
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(text: imageName),
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', "webp"],
                        );
                        if (result != null) {
                          PlatformFile file = result.files.first;

                          setState(() {
                            imageName = file.name;
                            imageInBytes = file.bytes;
                            imagePath = file.path;
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "product image is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffix: Icon(Icons.camera_alt_outlined),
                          labelText: "Select Product image:"),
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Select category',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: categories
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedCategories,
                          onChanged: (value) {
                            setState(() {
                              selectedCategories = value as String;
                            });
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "product description is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Enter product description:"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          formSubmit();
                        },
                        child: const Text("Submit"))
                  ],
                )));
      },
    );
  }

  void formSubmit() async {
    var isValid = _key.currentState!.validate();
    if (isValid) {
      if (kIsWeb) {
        imageUrl = await AddProductRepo.upLoadIamgeFile(imageInBytes);
      } else {
        imageUrl = await AddProductRepo.upLoadIamgeFile(imagePath);
      }
      if (imageUrl != "") {
        var productInfo = {
          "title": titleController.text.toString(),
          "price": priceController.text,
          "description": descriptionController.text.toString(),
          "category": selectedCategories,
          "image": imageUrl,
          "top": false,
          "ads": false,
          "paid": false
        };

        addProductBloc.add(AddProductDataEvent(formData: productInfo));
      }
    }
  }
}
