import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/Repo/Admin_repo.dart';
import 'package:e_commerce_app_bloc/Profile/Repo/Profile_repo.dart';
import 'package:e_commerce_app_bloc/Profile/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileWeb extends StatefulWidget {
  const ProfileWeb({super.key});

  @override
  State<ProfileWeb> createState() => _ProfileWebState();
}

class _ProfileWebState extends State<ProfileWeb> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? genderController;
  TextEditingController? dateController;
  final List<String> items = [
    'Male',
    'Female',
    'Other',
  ];
  String? selectedValue;
  ProfileBloc profileBloc = ProfileBloc();
  bool isAdmin = false;

  void initState() {
    // TODO: implement initState
    if (isAdmin == false) {
      AdminRepo.isAdmin().then((value) {
        setState(() {
          isAdmin = value;
        });
      });
    }
    profileBloc.add(FatchInitialProfileDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  )
                ]),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listenWhen: (previous, current) => current is ProfileActionState,
        buildWhen: (previous, current) => current is! ProfileActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchProfileLoadingState:
              return const Center(child: CircularProgressIndicator());
            case FatchProfileSuccessState:
              final success = state as FatchProfileSuccessState;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Container(
                    width: 50.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Stack(children: [
                          Center(
                              child: CircleAvatar(
                            radius: 50,
                            child: Center(
                                child: success.profileData["email"] != null
                                    ? CircleAvatar(
                                        child: Text(
                                          "${success.profileData["email"].toString().substring(0, 1).toUpperCase()}",
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Icon(
                                        Icons.person_2_outlined,
                                        size: 60,
                                      )),
                          )),
                        ]),
                        TextField(
                          controller: nameController = TextEditingController(
                              text: success.profileData["name"]),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  var key = success.profileData.keys.firstWhere(
                                      (k) =>
                                          success.profileData[k] ==
                                          success.profileData["name"]);
                                  if (key != null) {
                                    bottomSheetMoadal(
                                        key, success.profileData[key]);
                                  }
                                },
                                icon: Icon(Icons.edit),
                              ),
                              label: Text("Name")),
                        ),
                        TextField(
                          controller: dateController = TextEditingController(
                            text: success.profileData["birthDate"],
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  var key = success.profileData.keys.firstWhere(
                                      (k) =>
                                          success.profileData[k] ==
                                          success.profileData["birthDate"]);
                                  if (key != null) {
                                    bottomSheetMoadal(
                                        key, success.profileData[key]);
                                  }
                                },
                                icon: Icon(Icons.edit),
                              ),
                              label: Text("Birth date")),
                        ),
                        TextField(
                          controller: genderController = TextEditingController(
                              text: success.profileData["gender"]),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  var key = success.profileData.keys.firstWhere(
                                      (k) =>
                                          success.profileData[k] ==
                                          success.profileData["gender"]);
                                  if (key != null) {
                                    bottomSheetMoadal(
                                        key, success.profileData[key]);
                                  }
                                },
                                icon: Icon(Icons.edit),
                              ),
                              label: Text("Gender")),
                        ),
                        TextField(
                          controller: phoneController = TextEditingController(
                              text: success.profileData["number"]),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  var key = success.profileData.keys.firstWhere(
                                      (k) =>
                                          success.profileData[k] ==
                                          success.profileData["number"]);
                                  if (key != null) {
                                    bottomSheetMoadal(
                                        key, success.profileData[key]);
                                  }
                                },
                                icon: Icon(Icons.edit),
                              ),
                              label: Text("Phone")),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              logOut();
                            },
                            child: Text("Log Out"))

                        // DropdownButtonHideUnderline(
                        //   child: DropdownButton2(
                        //     hint: Text(
                        //       'Select Gender',
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         color: Theme.of(context).hintColor,
                        //       ),
                        //     ),
                        //     items: items
                        //         .map((item) => DropdownMenuItem<String>(
                        //               value: item,
                        //               child: Text(
                        //                 item,
                        //                 style: const TextStyle(
                        //                   fontSize: 14,
                        //                 ),
                        //               ),
                        //             ))
                        //         .toList(),
                        //     value: selectedValue,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         selectedValue = value as String;
                        //       });
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              );
          }
          return Container();
        },
      ),
    );
  }

  bottomSheetMoadal(key, value) {
    TextEditingController? profileDataController =
        TextEditingController(text: value);
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 5, color: Colors.orange)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Update ${key}:",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.red,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange))),
                    controller: profileDataController,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var isUpdate = await ProfileRepo.uploadToMongoDb(
                          {key: profileDataController.text});
                      if (isUpdate == true) {
                        Navigator.pop(context);
                        profileBloc.add(FatchInitialProfileDataEvent());
                      }
                    },
                    child: Text("Update"))
              ],
            ),
          ),
        );
      },
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('KEYLOGIN');
    context.go("/sign");
  }
}
