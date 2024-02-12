import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _sharedPreferences = Injection<SharedPreferences>();
  ThemeCubit(super.initialState);
  void toggle() {
    bool isdarktheme = (state == ThemeMode.dark);
    _sharedPreferences.setBool("current_theme", !isdarktheme);
    emit(isdarktheme ? ThemeMode.light : ThemeMode.dark);
  }
}
