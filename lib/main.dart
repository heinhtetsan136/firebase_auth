import 'package:flutter/material.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/route/router.dart';
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: StarlightUtils.navigatorKey,

      ///important
      theme: theme.copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.blue,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 1,
          ),
          drawerTheme: DrawerThemeData(
              width: context.width * 0.7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              backgroundColor: Colors.white),
          // colorScheme: theme.colorScheme.copyWith(
          //   // primary: const Color.fromARGB(255, 6, 125, 230),
          // ),
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.blue),
          )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              backgroundColor: const MaterialStatePropertyAll(Colors.blue),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: TextStyle(color: Colors.blue.shade300),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
              isDense: true,
              border: const OutlineInputBorder())),
      onGenerateRoute: router,
    );
  }
}
