import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/login/login_bloc.dart';
import 'package:login_logout/controller/login/login_event.dart';
import 'package:login_logout/controller/login/login_state.dart';
import 'package:login_logout/route/router.dart';
import 'package:starlight_utils/starlight_utils.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = context.read<LoginBloc>();
    void login() {
      loginBloc.passwordforcusnode.unfocus();
      loginBloc.add(const OnLoginEvent());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginBloc.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ).tr(),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: TextFormField(
                    ///login_field

                    onEditingComplete:
                        loginBloc.passwordforcusnode.requestFocus,
                    focusNode: loginBloc.emailfocusnode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) return "Email is required";
                      if (!value.isEmail) return "Invalid Email";
                      return null;
                    },
                    controller: loginBloc.emailController,
                    decoration: const InputDecoration(
                      labelText: "Enter Your Email",
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: loginBloc.isShow,
                    builder: (_, value, child) {
                      return TextFormField(
                        ///password field
                        onEditingComplete: login,
                        focusNode: loginBloc.passwordforcusnode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          final result = value?.isStrongPassword(
                            minLength: 8,
                          );
                          if (value == null) return "Password is required";
                          if (result != null) return result.toString();
                          return null;
                        },
                        controller: loginBloc.passwordController,
                        obscureText: !value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                loginBloc.toggle();
                              },
                              icon: Icon(
                                value ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey.shade500,
                              )),
                          labelText: "Enter Your Password",
                        ),
                      );
                    }),
                Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: context.width,
                    child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: BlocConsumer<LoginBloc, LoginBaseState>(
                          listener: (_, state) {
                            if (state is LoginSuccessState) {
                              StarlightUtils.pushReplacementNamed(
                                  RouteName.home);
                            }
                            if (state is LoginFailedState) {
                              StarlightUtils.dialog(AlertDialog(
                                title: const Text("Failed to Login"),
                                content: Text(state.error!),
                              ));
                            }
                          },
                          builder: (_, state) {
                            print(state);
                            if (state is LoginLoadingState) {
                              return const CupertinoActivityIndicator();
                            }

                            return const Text("Login");
                          },
                        ))),
                TextButton(
                    onPressed: () {
                      StarlightUtils.pushNamed(RouteName.forgetpassword);

                      ///To Do
                    },
                    child: const Text("Forget Password")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Create Your Account?"),
                    TextButton(
                        onPressed: () {
                          StarlightUtils.pushNamed(RouteName.register);
                        },
                        child: const Text("Sing up")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
