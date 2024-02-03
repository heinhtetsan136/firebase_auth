import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/register/register_bloc.dart';
import 'package:login_logout/controller/register/register_event.dart';
import 'package:login_logout/controller/register/register_state.dart';
import 'package:login_logout/route/router.dart';
import 'package:starlight_utils/starlight_utils.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterBloc>();
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          key: bloc.formkey,
          // key: loginBloc.formKey,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: TextFormField(
                        ///login_field
                        controller: bloc.emailcontroller,
                        onEditingComplete: bloc.passwordfocus.requestFocus,

                        // onEditingComplete: loginBloc.passwordforcusnode.requestFocus,
                        // focusNode: loginBloc.emailfocusnode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null) return "Email is required";
                          if (!value.isEmail) return "Invalid Email";
                          return null;
                        },
                        // controller: loginBloc.emailController,
                        decoration: const InputDecoration(
                          labelText: "Enter Your Email",
                        ),
                      ),
                    ),
                    // ValueListenableBuilder(
                    //     valueListenable: loginBloc.isShow,
                    //     builder: (_, value, child) {
                    //       return
                    ValueListenableBuilder(
                      valueListenable: bloc.passwordisShow,
                      builder: (_, value, child) {
                        return TextFormField(
                          focusNode: bloc.passwordfocus,
                          onEditingComplete: bloc.confirmfocus.requestFocus,

                          ///password field
                          // onEditingComplete: login,
                          // focusNode: loginBloc.passwordforcusnode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            final result = value?.isStrongPassword();
                            if (value == null) return "Password is required";
                            if (result != null) return result.toString();
                            return null;
                          },
                          controller: bloc.passwordcontroller,
                          obscureText: !value,
                          // controller: loginBloc.passwordController,
                          // obscureText: !value,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  bloc.toggelpassword();
                                  // loginBloc.toggle();
                                },
                                icon: Icon(
                                  value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey.shade500,
                                )),
                            labelText: "Enter Your Password",
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ValueListenableBuilder(
                        valueListenable: bloc.comfirmpasswordisShow,
                        builder: (_, value, child) {
                          return TextFormField(
                            focusNode: bloc.confirmfocus,
                            controller: bloc.confirmcontroller,
                            obscureText: !value,

                            ///password field
                            // onEditingComplete: login,
                            // focusNode: loginBloc.passwordforcusnode,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == bloc.passwordcontroller.text) {
                                return null;
                              }
                              return "Type the Same Password";
                              // final result = value?.isStrongPassword(
                              //     checkDigit: false,
                              //     minLength: 6,
                              //     checkSpecailChar: false);
                              // if (value == null) {
                              //   return "Comfirm Password is required";
                              // }
                              // if (result != null) return result.toString();
                              // return null;
                            },
                            // controller: loginBloc.passwordController,
                            // obscureText: !value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    bloc.togglecomfirm();
                                    // loginBloc.toggle();
                                  },
                                  icon: Icon(
                                    value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey.shade500,
                                  )),
                              labelText: "Comfirm Your Password",
                            ),
                          );
                        },
                      ),
                    ),

                    Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 20),
                        width: context.width,
                        child: ElevatedButton(
                            onPressed: () {
                              bloc.add(const OnRegisterEvent());
                              // login();
                            },
                            child:
                                BlocConsumer<RegisterBloc, RegisterBaseState>(
                              listener: (context, state) {
                                if (state is RegisterSucessState) {
                                  StarlightUtils.pushReplacementNamed(
                                      RouteName.home);
                                }
                                if (state is RegisterFailedState) {
                                  StarlightUtils.snackbar(SnackBar(
                                      content: Text(state.error.toString())));
                                }
                              },
                              builder: (_, state) {
                                if (state is RegisterLoadingState) {
                                  return const Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                }
                                return const Text("Create New User");
                              },
                            ))),

                    // BlocConsumer<LoginBloc, LoginBaseState>(
                    //   listener: (_, state) {
                    //     if (state is LoginSuccessState) {
                    //       StarlightUtils.pushNamed(RouteName.home);
                    //     }
                    //     if (state is LoginFailedState) {
                    //       StarlightUtils.dialog(AlertDialog(
                    //         title: const Text("Failed to Login"),
                    //         content: Text(state.error!),
                    //       ));
                    //     }
                    //   },
                    //   builder: (_, state) {
                    //     print(state);
                    //     if (state is LoginLoadingState) {
                    //       return const CupertinoActivityIndicator();
                    //     }

                    //     return const

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              StarlightUtils.pushNamed(RouteName.login);
                            },
                            child: const Text("Log in")),
                      ],
                    )
                  ]))),
    ));
  }
}
