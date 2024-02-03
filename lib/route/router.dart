import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/forget_password/forget_password_cubit.dart';
import 'package:login_logout/controller/home/home_bloc.dart';
import 'package:login_logout/controller/home/home_state.dart';
import 'package:login_logout/controller/login/login_bloc.dart';
import 'package:login_logout/controller/register/register_bloc.dart';
import 'package:login_logout/repositories/AuthService.dart';
import 'package:login_logout/screen/forgetpassword_screen.dart';
import 'package:login_logout/screen/home_screen.dart';
import 'package:login_logout/screen/login_screen.dart';
import 'package:login_logout/screen/register_screen.dart';

List<String> protectroute = ["/", "/login", "/register"];

abstract class RouteName {
  static const String login = "/login";
  static const String home = "/";
  static const String register = "/register";
  static const String forgetpassword = "/password";
}

Route? _protectedroute(String path, Widget child, RouteSettings setting) {
  return _route(
      Injection<AuthService>().currentUser == null &&
              protectroute.contains(path)
          ? BlocProvider(
              create: (_) => LoginBloc(), child: const Login_Screen())
          : child,
      setting);
}

Route? router(RouteSettings setting) {
  String incomingroute = setting.name ?? '/';

  // final bool isloggedin=FirebaseAuth.instance.currentUser != null;// if user has true
  // if(  (incomingroute=="/") && (!isloggedin) )
  // {
  //   incomingroute="/login";
  // }
  switch (incomingroute) {
    case RouteName.forgetpassword:
      return _protectedroute(
          incomingroute,
          BlocProvider(
              child: const ForgetPassword(),
              create: (_) => ForgetPasswordCubit()),
          setting);
    case RouteName.home:
      return _protectedroute(
          incomingroute,
          BlocProvider(
              create: (_) => HomeBloc(
                  HomeInitialState(Injection<AuthService>().currentUser)),
              lazy: false,
              child: const HomeScreen()),
          setting);
    case RouteName.login:
      return _protectedroute(
          incomingroute,
          BlocProvider(create: (_) => LoginBloc(), child: const Login_Screen()),
          setting);
    case RouteName.register:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (_) => RegisterBloc(), child: const RegisterScreen()),
      );
    default:
      return _route(
          const Scaffold(
            body: Center(
              child: Text("Not Found"),
            ),
          ),
          setting);
  }
}

Route _route(Widget child, RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => child, settings: settings);
}
