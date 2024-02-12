import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/theme/theme_cubit.dart';
import 'package:login_logout/route/router.dart';
import 'package:login_logout/theme/dark_theme.dart';
import 'package:login_logout/theme/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starlight_utils/starlight_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  // await Injection<AuthService>().currentUser?.updateDisplayName("HHS");
  // await Injection<AuthService>().singout();
  // AuthService().register("heinhtetsan136@gmail.com", "dsjfksj").then(print);
  // await FirebaseAuth.instance.signInAnonymously();
  // await FirebaseAuth.instance.signOut();
  // await FirebaseAuth.instance
  // await Injection<AuthService>().login("test@gmail.com", "123HHhh");
  //     .signInWithEmailAndPassword(email: "test@gmail.com", password: "123HHhh");
  runApp(const MainApp());
}

final theme = ThemeData.light();
final darktheme = ThemeData.dark();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(
          Injection<SharedPreferences>().getBool("current_theme") == true
              ? ThemeMode.dark
              : ThemeMode.light),
      child: Builder(builder: (newcontext) {
        return BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
          return MaterialApp(
            navigatorKey: StarlightUtils.navigatorKey,

            ///important
            themeMode: state,
            theme: lighttheme(theme, context),
            darkTheme: darkTheme(darktheme, context),
            onGenerateRoute: router,
          );
        });
      }),
    );
  }
}
