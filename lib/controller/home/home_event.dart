import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeBaseEvent {
  const HomeBaseEvent();
}

class DisplayNameChangeEvent extends HomeBaseEvent {
  const DisplayNameChangeEvent();
}

class UploadProfileEvent extends HomeBaseEvent {
  const UploadProfileEvent();
}

class PasswordChangeEvent extends HomeBaseEvent {
  const PasswordChangeEvent();
}

class Singout extends HomeBaseEvent {
  final User? user;
  const Singout([this.user]);
}

class UserChangedEvent extends HomeBaseEvent {
  final User user;
  const UserChangedEvent(this.user);
}
