import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:login_logout/firebase_options.dart';
import 'package:login_logout/repositories/AuthService.dart';

final Injection = GetIt.instance;

Future<void> setup()async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Injection.registerSingleton(AuthService(),dispose:(instance)=>instance.dispose());
//   Injection.registerSingleton<AppModel>(AppModel());

// // Alternatively you could write it if you don't like global variables
//   GetIt.I.registerSingleton<AppModel>(AppModel());
}