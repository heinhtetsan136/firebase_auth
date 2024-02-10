import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/update_password/update_password_state.dart';

class UpdatePasswordCubic extends Cubit<UpdatePasswordState> {
  final User user;
  UpdatePasswordCubic(this.user) : super(const UpdatePasswordInitialState());
  final TextEditingController controller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  final FocusNode passwordfocusNode = FocusNode();
  // final AuthService _auth = Injection<AuthService>();

  Future<void> UpdateEmail(
    String password,
  ) async {
    focusNode.unfocus();
    passwordfocusNode.unfocus();

    if (formstate.currentState?.validate() != true) return;
    if (state is UpdatePasswordLoadingState) return;

    emit(const UpdatePasswordLoadingState());

    try {
      final result = await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: user.email!, password: passwordcontroller.text));
      await result.user!.updatePassword(password);

      emit(const UpdatePasswordSucessState());
    } on FirebaseAuthException catch (e) {
      emit(UpdatePasswordFailedState(e.message.toString()));
    } catch (e) {
      emit(UpdatePasswordFailedState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    passwordcontroller.dispose();
    passwordfocusNode.dispose();
    controller.dispose();
    focusNode.dispose(); // TODO: implement close
    return super.close();
  }
}
