import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/home/home_event.dart';
import 'package:login_logout/controller/home/home_state.dart';
import 'package:login_logout/repositories/AuthService.dart';

class HomeBloc extends Bloc<HomeBaseEvent, HomeBaseState> {
  final GlobalKey<ScaffoldState> drawerkey = GlobalKey<ScaffoldState>();
  final _auth = Injection<AuthService>();
  StreamSubscription? _authstate;
  HomeBloc(super.initialState) {
    _authstate = _auth.authState.listen((event) {
      if (event == null) {
        add(const Singout());
      } else {
        add(UserChangedEvent(event));
      }
    });
    on<UserChangedEvent>((event, emit) {
      emit(HomeUserChangedState(event.user));
    });

    on<Singout>((event, emit) {
      emit(const HomeSignoutState());
    });
  }
  @override
  Future<void> close() {
    drawerkey.currentState?.dispose();
    _authstate?.cancel();
    // TODO: implement close
    return super.close();
  }
}
