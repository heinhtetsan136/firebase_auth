import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/forget_password/forget_password_cubit.dart';
import 'package:login_logout/controller/forget_password/forget_password_state.dart';
import 'package:starlight_utils/starlight_utils.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgetPasswordCubit>();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: bloc.formstate,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Forgot Password",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: TextFormField(
                  controller: bloc.emailcontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) return "Email is required";
                    return value.isEmail ? null : "Invalid Email";
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Your Email",
                  ),
                ),
              ),
              SizedBox(
                  height: 50,
                  width: context.width,
                  child: ElevatedButton(
                      onPressed: bloc.sendEmail,
                      child: BlocConsumer<ForgetPasswordCubit,
                          ForgetPasswordState>(
                        listener: (_, state) {
                          print("state is $state");
                          if (state is ForgetPasswordFailedState) {
                            StarlightUtils.snackbar(
                                SnackBar(content: Text(state.error)));
                          }
                          if (state is ForgetPasswordSucessState) {
                            StarlightUtils.pop();
                            StarlightUtils.snackbar(const SnackBar(
                                content: Text("Verification mail was sent")));
                          }
                        },
                        builder: (_, state) {
                          if (state is ForgetPasswordLoadingState) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }
                          return const Text("Send Reset Link");
                        },
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
