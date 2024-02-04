import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/register/register_event.dart';
import 'package:login_logout/controller/register/register_state.dart';
import 'package:login_logout/repositories/AuthService.dart';

class RegisterBloc extends Bloc<RegisterBaseEvent, RegisterBaseState> {
  final AuthService _auth = Injection<AuthService>();
  RegisterBloc() : super(const RegisterInitialState()) {
    on<OnRegisterEvent>((event, emit) async {
      if (formkey!.currentState?.validate() == false ||
          state is RegisterLoadingState) return;
      emit(const RegisterLoadingState());
      final result =
          await _auth.register(emailcontroller.text, passwordcontroller.text);
      if (result.isError) {
        return emit(RegisterFailedState(result.error.toString()));
      }
      await _auth.currentUser?.sendEmailVerification();
      emit(const RegisterSucessState());
    });
  }
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmcontroller = TextEditingController();
  final FocusNode passwordfocus = FocusNode();
  final FocusNode confirmfocus = FocusNode();
  GlobalKey<FormState>? formkey = GlobalKey<FormState>();
  final ValueNotifier<bool> passwordisShow = ValueNotifier(false);
  final ValueNotifier<bool> comfirmpasswordisShow = ValueNotifier(false);
  void toggelpassword() {
    passwordisShow.value = !passwordisShow.value;
  }

  void togglecomfirm() {
    comfirmpasswordisShow.value = !comfirmpasswordisShow.value;
  }

  @override
  Future<void> close() {
    passwordisShow.dispose();
    comfirmpasswordisShow.dispose();

    formkey = null;
    passwordfocus.dispose();
    confirmfocus.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmcontroller.dispose();
    // TODO: implement close
    return super.close();
  }
}
