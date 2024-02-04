import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/upade_username/update_username_state.dart';

class UpdateUserNameCubic extends Cubit<UpdateUserNameState> {
  final User user;
  UpdateUserNameCubic(this.user) : super(const UpdateUsernameInitialState());
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  Future<void> UpdateUsername(String displayName) async {
    focusNode.unfocus();
    if (formstate.currentState?.validate() != true) return;
    if (state is UpdateUsernameLoadingState) return;
    emit(const UpdateUsernameLoadingState());
    try {
      await user.updateDisplayName(displayName);
      emit(const UpdateUsernameSucessState());
    } on FirebaseAuthException catch (e) {
      emit(UpdateUsernameFailedState(e.toString()));
    } catch (e) {
      emit(UpdateUsernameFailedState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    focusNode.dispose(); // TODO: implement close
    return super.close();
  }
}
