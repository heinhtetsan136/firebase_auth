abstract class UpdateEmailState {
  const UpdateEmailState();
}

class UpdateEmailInitialState extends UpdateEmailState {
  const UpdateEmailInitialState();
}

class UpdateEmailLoadingState extends UpdateEmailState {
  const UpdateEmailLoadingState();
}

class UpdateEmailSucessState extends UpdateEmailState {
  const UpdateEmailSucessState();
}

class UpdateEmailFailedState extends UpdateEmailState {
  final String? message;
  const UpdateEmailFailedState(this.message);
}
