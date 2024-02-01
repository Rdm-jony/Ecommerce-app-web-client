import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeToAllproductsNavigateEvent>(homeToAllproductsNavigateEvent);
  }

  FutureOr<void> homeToAllproductsNavigateEvent(
      HomeToAllproductsNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeToAllproductsNavigateState());
  }
}
