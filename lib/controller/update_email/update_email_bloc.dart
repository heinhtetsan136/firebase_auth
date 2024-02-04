import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/update_email/update_email_state.dart';
import 'package:login_logout/repositories/AuthService.dart';

class UpdateEmailCubic extends Cubit<UpdateEmailState> {
  final User user;
  UpdateEmailCubic(this.user) : super(const UpdateEmailInitialState());
  final TextEditingController controller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  final FocusNode passwordfocusNode = FocusNode();
  final AuthService _auth = Injection<AuthService>();

  Future<void> UpdateEmail(
    String email,
  ) async {
    focusNode.unfocus();
    passwordfocusNode.unfocus();
    if (formstate.currentState?.validate() != true) return;
    if (state is UpdateEmailLoadingState) return;
    emit(const UpdateEmailLoadingState());
    try {
      final result = await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: user.email!, password: passwordcontroller.text));
      await result.user!.updateEmail(email);

      emit(const UpdateEmailSucessState());
    } on FirebaseAuthException catch (e) {
      emit(UpdateEmailFailedState(e.message));
    } catch (e) {
      emit(UpdateEmailFailedState(e.toString()));
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
