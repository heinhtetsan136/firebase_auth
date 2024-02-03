import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/login/login_event.dart';
import 'package:login_logout/controller/login/login_state.dart';
import 'package:login_logout/models/Response.dart';
import 'package:login_logout/repositories/AuthService.dart';

class LoginBloc extends Bloc<LoginBaseEvent, LoginBaseState> {
  final AuthService _auth = Injection<AuthService>();
  LoginBloc() : super(const LoginInitialState()) {
    on<OnLoginEvent>((event, emit) async {
      if (state is LoginLoadingState ||
          formKey?.currentState?.validate() != true) {
        return;
      }

      emit(const LoginLoadingState());

      final Response result11 =
          await _auth.login(emailController.text, passwordController.text);

      if (result11.isError) {
        return emit(LoginFailedState(error: result11.error!));
      }
      emit(const LoginSuccessState());
    });
  }
  final ValueNotifier<bool> isShow = ValueNotifier(false);
  void toggle() {
    isShow.value = !isShow.value;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailfocusnode = FocusNode();
  final FocusNode passwordforcusnode = FocusNode();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  @override
  Future<void> close() {
    emailfocusnode.dispose();
    passwordController.dispose();
    formKey == null;
    emailController.dispose();
    passwordController.dispose();
    isShow.dispose();
    // TODO: implement close
    return super.close();
  }
}
