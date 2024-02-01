import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_bloc/Profile/Model/ProfileDataModel.dart';
import 'package:e_commerce_app_bloc/Profile/Repo/Profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FatchInitialProfileDataEvent>(fatchInitialProfileDataEvent);
    on<UploadImageEvent>(uploadImageEvent);
  }

  FutureOr<void> fatchInitialProfileDataEvent(
      FatchInitialProfileDataEvent event, Emitter<ProfileState> emit) async {
    emit(FatchProfileLoadingState());
    final profileData = await ProfileRepo.fatchProfileData();

    emit(FatchProfileSuccessState(profileData: profileData));
  }

  FutureOr<void> uploadImageEvent(
      UploadImageEvent event, Emitter<ProfileState> emit) async {
    print("caallllliiiinnngggg");
    bool isUpdate = await ProfileRepo.uploadImage();
    if (isUpdate == true) {
      final profileData = await ProfileRepo.fatchProfileData();

      emit(FatchProfileSuccessState(profileData: profileData));
    }
  }
}
