import 'package:e_commerce_app_bloc/AdminPanel/ManageUser/bloc/manage_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  ManageUserBloc manageUserBloc = ManageUserBloc();
  @override
  void initState() {
    manageUserBloc.add(FatchAllUsersEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: BlocConsumer<ManageUserBloc, ManageUserState>(
        bloc: manageUserBloc,
        listenWhen: (previous, current) => current is ManageUserActionState,
        buildWhen: (previous, current) => current is! ManageUserActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchAllUsersLodingState:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case FatchAllUsersSuccessState:
              final success = state as FatchAllUsersSuccessState;
              return ListView.builder(
                itemCount: success.allUsers.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.square(
                            dimension: 50,
                            child: success.allUsers[index]?.image == ""
                                ? Icon(
                                    Icons.person,
                                    size: 50,
                                  )
                                : Image.network(success.allUsers[index].image),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            success.allUsers[index].email,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            success.allUsers[index].name,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          success.allUsers[index].role == "admin"
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    manageUserBloc.add(UserToAdminEvent(
                                        email: success.allUsers[index].email,
                                        role: "user"));
                                  },
                                  child: Text(
                                    "Undo",
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    manageUserBloc.add(UserToAdminEvent(
                                        email: success.allUsers[index].email,
                                        role: "admin"));
                                  },
                                  child: const Text(
                                    "Create Admin",
                                    style: TextStyle(color: Colors.white),
                                  )),
                          SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {},
                              child: const Text(
                                "Delete User",
                                style: TextStyle(color: Colors.white),
                              ))
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
    ));
  }
}
