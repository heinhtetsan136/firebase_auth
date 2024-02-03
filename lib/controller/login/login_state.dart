abstract class LoginBaseState {
  const LoginBaseState();
}

class LoginInitialState extends LoginBaseState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginBaseState {
  const LoginLoadingState();
}

class LoginSuccessState extends LoginBaseState {
  const LoginSuccessState();
}

class LoginFailedState extends LoginBaseState {
  final String? error;

  const LoginFailedState({required this.error});
}
