abstract class UpdatePasswordState {
  const UpdatePasswordState();
}

class UpdatePasswordInitialState extends UpdatePasswordState {
  const UpdatePasswordInitialState();
}

class UpdatePasswordLoadingState extends UpdatePasswordState {
  const UpdatePasswordLoadingState();
}

class UpdatePasswordSucessState extends UpdatePasswordState {
  const UpdatePasswordSucessState();
}

class UpdatePasswordFailedState extends UpdatePasswordState {
  final String message;
  const UpdatePasswordFailedState(this.message);
}
