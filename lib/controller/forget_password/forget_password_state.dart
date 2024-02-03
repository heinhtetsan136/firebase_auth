abstract class ForgetPasswordState {
  const ForgetPasswordState();
}

class ForgetPasswordInitialState extends ForgetPasswordState {
  const ForgetPasswordInitialState();
}

class ForgetPasswordLoadingState extends ForgetPasswordState {
  const ForgetPasswordLoadingState();
}

class ForgetPasswordSucessState extends ForgetPasswordState {
  const ForgetPasswordSucessState();
}

class ForgetPasswordFailedState extends ForgetPasswordState {
  String error;
  ForgetPasswordFailedState(this.error);
}
