import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_logout/firebase_options.dart';
import 'package:login_logout/repositories/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Injection = GetIt.instance;

Future<void> setup() async {
  await EasyLocalization.ensureInitialized();

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  Injection.registerLazySingleton(() => sharedPreferences);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Injection.registerSingleton(AuthService(),
      dispose: (instance) => instance.dispose());
  Injection.registerLazySingleton<ImagePicker>(() => ImagePicker());
  Injection.registerLazySingleton<FirebaseStorage>(
      () => FirebaseStorage.instance);
  Injection.registerLazySingleton(() => FirebaseFirestore.instance);
//   Injection.registerSingleton<AppModel>(AppModel());

// // Alternatively you could write it if you don't like global variables
//   GetIt.I.registerSingleton<AppModel>(AppModel());
}
