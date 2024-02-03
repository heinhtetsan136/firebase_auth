abstract class RegisterBaseState {
  const RegisterBaseState();
}

class RegisterInitialState extends RegisterBaseState {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterBaseState {
  const RegisterLoadingState();
}

class RegisterSucessState extends RegisterBaseState {
  const RegisterSucessState();
}

class RegisterFailedState extends RegisterBaseState {
  final String error;
  const RegisterFailedState(this.error);
}
