import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/home/home_bloc.dart';
import 'package:login_logout/controller/home/home_event.dart';
import 'package:login_logout/controller/home/home_state.dart';
import 'package:login_logout/repositories/AuthService.dart';
import 'package:login_logout/route/router.dart';
import 'package:starlight_utils/starlight_utils.dart';

void gotoCreateNote() {
  StarlightUtils.pushNamed(RouteName.createpost);
}

void gotoUpdateScreen() {
  StarlightUtils.pop();
  Future.delayed(const Duration(milliseconds: 200),
      () => StarlightUtils.pushNamed(RouteName.updateUserName));
}

void gotoUpdatepasswordScreen() {
  StarlightUtils.pop();
  Future.delayed(const Duration(milliseconds: 200),
      () => StarlightUtils.pushNamed(RouteName.updatepassword));
}

void gotoUpdateEmailScreen() {
  StarlightUtils.pop();
  Future.delayed(const Duration(milliseconds: 200),
      () => StarlightUtils.pushNamed(RouteName.updateEmail));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocListener<HomeBloc, HomeBaseState>(
      listener: (_, state) async {
        if (state is HomeSignoutState) {
          StarlightUtils.pushReplacementNamed(RouteName.login);
          await Injection<AuthService>().singout();
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: bloc.drawerkey,
          floatingActionButton: const FloatingActionButton(
              onPressed: gotoCreateNote, child: Icon(Icons.edit)),
          drawer: Drawer(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    bloc.add(const UploadProfileEvent());
                  },
                  child: UserAccountsDrawerHeader(
                      currentAccountPicture: BlocBuilder<HomeBloc,
                              HomeBaseState>(
                          buildWhen: (previous, current) =>
                              previous.user?.photoURL != current.user?.photoURL,
                          builder: (_, state) {
                            bool isNOtuploaded = state.user?.photoURL == null;
                            if (isNOtuploaded) {
                              return CircleAvatar(
                                child: !isNOtuploaded
                                    ? null
                                    : Text((state.user?.displayName ??
                                            state.user?.email ??
                                            "NA")[0]
                                        .toUpperCase()),
                              );
                            }
                            return FutureBuilder(
                                future: Injection<FirebaseStorage>()
                                    .ref(state.user?.photoURL)
                                    .getDownloadURL(),
                                builder: (_, snap) {
                                  if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CupertinoActivityIndicator();
                                  }
                                  final url = snap.data;
                                  if (url == null) {
                                    return CircleAvatar(
                                      child: !isNOtuploaded
                                          ? null
                                          : Text((state.user?.displayName ??
                                                  state.user?.email ??
                                                  "NA")[0]
                                              .toUpperCase()),
                                    );
                                  }
                                  return ClipOval(
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (_, child, chunk) {
                                        if (chunk == null) return child;
                                        return const CupertinoActivityIndicator();
                                      },
                                    ),
                                  );
                                });
                          }),
                      accountName: BlocBuilder<HomeBloc, HomeBaseState>(
                          buildWhen: (previous, current) =>
                              previous.user?.displayName !=
                              current.user?.displayName,
                          builder: (_, state) {
                            print(state.user?.displayName);
                            return Text(state.user?.displayName ?? "Username");
                          }),
                      accountEmail: BlocBuilder<HomeBloc, HomeBaseState>(
                          buildWhen: (previous, current) =>
                              previous.user?.email != current.user?.email,
                          builder: (_, state) {
                            return Text(state.user?.email ?? "");
                          })),
                ),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: gotoUpdateScreen,
                        title: Text("Change Username"),
                      ),
                      ListTile(
                        onTap: gotoUpdateEmailScreen,
                        title: Text("Change Email"),
                      ),
                      ListTile(
                        onTap: gotoUpdatepasswordScreen,
                        title: Text("Change Password"),
                      )
                    ],
                  ),
                )),
                ListTile(
                  onTap: () {
                    bloc.add(const Singout());
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Log out"),
                ),
                const ListTile(
                  title: Text("Version 1.0.0"),
                )
              ],
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  bloc.drawerkey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu)),
            title: const Text("Note App"),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         bloc.add(const Singout());
            //       },
            //       icon: const Icon(Icons.logout)),
            // ],
          ),
        ),
      ),
    );
  }
}
