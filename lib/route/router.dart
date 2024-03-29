import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/forget_password/forget_password_cubit.dart';
import 'package:login_logout/controller/home/home_bloc.dart';
import 'package:login_logout/controller/home/home_state.dart';
import 'package:login_logout/controller/login/login_bloc.dart';
import 'package:login_logout/controller/note_create/note_create_cubic.dart';
import 'package:login_logout/controller/register/register_bloc.dart';
import 'package:login_logout/controller/upade_username/update_username_cubic.dart';
import 'package:login_logout/controller/update_email/update_email_bloc.dart';
import 'package:login_logout/controller/update_password/update_password_cubic.dart';
import 'package:login_logout/models/note_model.dart';
import 'package:login_logout/repositories/AuthService.dart';
import 'package:login_logout/screen/create_post_screen.dart';
import 'package:login_logout/screen/forgetpassword_screen.dart';
import 'package:login_logout/screen/home_screen.dart';
import 'package:login_logout/screen/login_screen.dart';
import 'package:login_logout/screen/register_screen.dart';
import 'package:login_logout/screen/update_email_screen.dart';
import 'package:login_logout/screen/update_password_screen.dart';
import 'package:login_logout/screen/update_username_screen.dart';

List<String> protectroute = ["/", "/login", "/register"];

abstract class RouteName {
  static const String login = "/login";
  static const String home = "/";
  static const String register = "/register";
  static const String forgetpassword = "/password";
  static const String updateUserName = "/updateusername";
  static const String updateEmail = "/updateemail";
  static const String updatepassword = "/updatepassword";
  static const String notes = "/note";
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
    case RouteName.notes:
      if ((!(setting.arguments == null)) &&
          ((setting.arguments is! NoteModel))) {
        return _protectedroute(
            incomingroute,
            Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text("Bad Request"),
              ),
            ),
            setting);
      }
      return _protectedroute(
          incomingroute,
          BlocProvider(
              create: (_) => NoteCubit(setting.arguments as NoteModel?),
              child: const NoteScreen()),
          setting);

    case RouteName.forgetpassword:
      return _protectedroute(
          incomingroute,
          BlocProvider(
              child: const ForgetPassword(),
              create: (_) => ForgetPasswordCubit()),
          setting);
    case RouteName.updatepassword:
      return _protectedroute(
          incomingroute,
          BlocProvider(
            create: (_) =>
                UpdatePasswordCubic(Injection<AuthService>().currentUser!),
            child: const UpdatePassword(),
          ),
          setting);
    case RouteName.updateUserName:
      return _protectedroute(
          incomingroute,
          BlocProvider(
              create: (_) =>
                  UpdateUserNameCubic(Injection<AuthService>().currentUser!),
              child: const UpdateUsername()),
          setting);
    case RouteName.updateEmail:
      return _protectedroute(
          incomingroute,
          BlocProvider(
            create: (_) =>
                UpdateEmailCubic(Injection<AuthService>().currentUser!),
            child: const UpdateEmail(),
          ),
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
