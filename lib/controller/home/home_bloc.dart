import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/home/home_event.dart';
import 'package:login_logout/controller/home/home_state.dart';
import 'package:login_logout/repositories/AuthService.dart';
import 'package:starlight_utils/starlight_utils.dart';

class HomeBloc extends Bloc<HomeBaseEvent, HomeBaseState> {
  final GlobalKey<ScaffoldState> drawerkey = GlobalKey<ScaffoldState>();
  final _auth = Injection<AuthService>();
  final _imagepicker = Injection<ImagePicker>();
  final _storage = Injection<FirebaseStorage>();
  StreamSubscription? _authstate;
  HomeBloc(super.initialState) {
    _authstate = _auth.authState.listen((event) {
      if (event == null) {
        add(const Singout());
      } else {
        add(UserChangedEvent(event));
      }
    });
    on<UserChangedEvent>((event, emit) {
      emit(HomeUserChangedState(event.user));
    });
    on<UploadProfileEvent>((event, emit) async {
      final ImageSource? userchoice = await StarlightUtils.dialog(AlertDialog(
        title: const Text("Choice Method"),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  StarlightUtils.pop(result: ImageSource.camera);
                },
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  StarlightUtils.pop(result: ImageSource.gallery);
                },
                leading: const Icon(Icons.browse_gallery),
                title: const Text("Gallery"),
              )
            ],
          ),
        ),
      ));
      if (userchoice == null) return;

      // emit(const UploadProfile());
      final XFile? image = await _imagepicker.pickImage(source: userchoice);
      if (image == null) return;
      emit(ImageUploadLoadingState(state.user));
      final point = _storage.ref(
          "/profile/${_auth.currentUser?.uid}/${DateTime.now().toString().replaceAll(" ", "")}.${image.name.split(".").last}");

      final fullpath = await point.putFile(File(image.path));
      await _auth.currentUser?.updatePhotoURL(fullpath.ref.fullPath);
    });
    on<Singout>((event, emit) {
      emit(const HomeSignoutState());
    });
  }
  @override
  Future<void> close() {
    drawerkey.currentState?.dispose();
    _authstate?.cancel();
    // TODO: implement close
    return super.close();
  }
}
