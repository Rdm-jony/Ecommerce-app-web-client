import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce_app_bloc/Authentication/Sign_in/Ui/Sign_in_screen.dart';
import 'package:e_commerce_app_bloc/Profile/Repo/Profile_repo.dart';
import 'package:e_commerce_app_bloc/Profile/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  void initState() {
    // TODO: implement initState
    profileBloc.add(FatchInitialProfileDataEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
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
              return Column(
                children: [
                  Stack(children: [
                    Center(
                        child: CircleAvatar(
                      radius: 50,
                      child: Center(
                          child: success.profileData["image"] != ""
                              ? CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(
                                      success.profileData["image"]),
                                )
                              : Icon(
                                  Icons.person_2_outlined,
                                  size: 60,
                                )),
                    )),
                    Positioned(
                        bottom: -10,
                        right: 140,
                        child: IconButton(
                            onPressed: () {
                              profileBloc.add(UploadImageEvent());
                            },
                            icon: Icon(Icons.camera_alt_outlined)))
                  ]),
                  TextField(
                    controller: nameController = TextEditingController(
                        text: success.profileData["name"]),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            var key = success.profileData.keys.firstWhere((k) =>
                                success.profileData[k] ==
                                success.profileData["name"]);
                            if (key != null) {
                              bottomSheetMoadal(key, success.profileData[key]);
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
                            var key = success.profileData.keys.firstWhere((k) =>
                                success.profileData[k] ==
                                success.profileData["birthDate"]);
                            if (key != null) {
                              bottomSheetMoadal(key, success.profileData[key]);
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
                            var key = success.profileData.keys.firstWhere((k) =>
                                success.profileData[k] ==
                                success.profileData["gender"]);
                            if (key != null) {
                              bottomSheetMoadal(key, success.profileData[key]);
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
                            var key = success.profileData.keys.firstWhere((k) =>
                                success.profileData[k] ==
                                success.profileData["number"]);
                            if (key != null) {
                              bottomSheetMoadal(key, success.profileData[key]);
                            }
                          },
                          icon: Icon(Icons.edit),
                        ),
                        label: Text("Phone")),
                  ),
                  ElevatedButton(
                      onPressed: () {
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Signin(),
        ));
  }
}
