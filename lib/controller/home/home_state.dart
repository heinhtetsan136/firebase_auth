import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeBaseState {
  final User? user;
  const HomeBaseState([this.user]);
}

class HomeInitialState extends HomeBaseState {
  const HomeInitialState(super.user);
}

class HomeLoadingState extends HomeBaseState {
  const HomeLoadingState(super.user);
}

class HomeSucessState extends HomeBaseState {
  const HomeSucessState(super.user);
}

class HomeErrorState extends HomeBaseState {
  const HomeErrorState(super.user);
}

class HomeSignoutState extends HomeBaseState {
  const HomeSignoutState([super.user]);
}

class HomeUserChangedState extends HomeBaseState {
  const HomeUserChangedState(super.user);
}

class UploadProfile extends HomeBaseState {
  const UploadProfile([super.user]);
}

class ImageUploadLoadingState extends HomeBaseState {
  const ImageUploadLoadingState(super.user);
}
