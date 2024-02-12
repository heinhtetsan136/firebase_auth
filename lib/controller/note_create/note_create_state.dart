abstract class NoteCreateBaseState {
  const NoteCreateBaseState();
}

class NoteCreateInitialState extends NoteCreateBaseState {
  const NoteCreateInitialState();
}

class NoteCreateLoadingState extends NoteCreateBaseState {
  const NoteCreateLoadingState();
}

class NoteCreateSucessState extends NoteCreateBaseState {
  const NoteCreateSucessState();
}

class NoteCreateFailedState extends NoteCreateBaseState {
  final String error;
  const NoteCreateFailedState(this.error);
}
