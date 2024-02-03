import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/forget_password/forget_password_state.dart';
import 'package:login_logout/models/Response.dart';
import 'package:login_logout/repositories/AuthService.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(const ForgetPasswordInitialState());
  GlobalKey<FormState>? formstate = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final AuthService _auth = Injection<AuthService>();
  Future<void> sendEmail() async {
    if (formstate?.currentState?.validate() != true ||
        state is ForgetPasswordLoadingState) return;
    emit(const ForgetPasswordLoadingState());
    final Response result = await _auth.reset(emailcontroller.text);
    print(result);
    if (result.isError) {
      return emit(ForgetPasswordFailedState(result.error.toString()));
    }
    emit(const ForgetPasswordSucessState());
  }

  @override
  Future<void> close() {
    formstate = null;
    emailcontroller.dispose();
    // TODO: implement close
    return super.close();
  }
}
