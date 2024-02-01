import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/AdminPanel/DashBoard/Admin/Repo/Admin_repo.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<IsAdminEvent>(isAdminEvent);
  }

  FutureOr<void> isAdminEvent(
      IsAdminEvent event, Emitter<AdminState> emit) async {
    bool isAdmin = await AdminRepo.isAdmin();
    print(isAdmin);
    if (isAdmin) {
      emit(IsAdminState());
    }
  }
}
