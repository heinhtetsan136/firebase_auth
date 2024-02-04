abstract class UpdateUserNameState {
  const UpdateUserNameState();
}

class UpdateUsernameInitialState extends UpdateUserNameState {
  const UpdateUsernameInitialState();
}

class UpdateUsernameLoadingState extends UpdateUserNameState {
  const UpdateUsernameLoadingState();
}

class UpdateUsernameSucessState extends UpdateUserNameState {
  const UpdateUsernameSucessState();
}

class UpdateUsernameFailedState extends UpdateUserNameState {
  final String message;
  const UpdateUsernameFailedState(this.message);
}
