import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/AdminPanel/ManageUser/Repo/ManageUser_repo.dart';
import 'package:meta/meta.dart';

part 'manage_user_event.dart';
part 'manage_user_state.dart';

class ManageUserBloc extends Bloc<ManageUserEvent, ManageUserState> {
  ManageUserBloc() : super(ManageUserInitial()) {
    on<FatchAllUsersEvent>(fatchAllUsersEvent);
    on<UserToAdminEvent>(userToAdminEvent);
  }

  FutureOr<void> fatchAllUsersEvent(
      FatchAllUsersEvent event, Emitter<ManageUserState> emit) async {
    emit(FatchAllUsersLodingState());
    final List allUsers = await ManageUserRepo.fatchUserData();
    emit(FatchAllUsersSuccessState(allUsers: allUsers));
  }

  FutureOr<void> userToAdminEvent(
      UserToAdminEvent event, Emitter<ManageUserState> emit) async {
    bool isTrue = await ManageUserRepo.userToAdmin(event.email, event.role);
    if (isTrue) {
      final List allUsers = await ManageUserRepo.fatchUserData();
      emit(FatchAllUsersSuccessState(allUsers: allUsers));
    }
  }
}
