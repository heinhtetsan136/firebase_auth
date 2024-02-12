import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/update_password/update_password_cubic.dart';
import 'package:login_logout/controller/update_password/update_password_state.dart';
import 'package:starlight_utils/starlight_utils.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdatePasswordCubic>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Password"),
        actions: [
          IconButton(
              onPressed: () {
                bloc.UpdateEmail(bloc.controller.text);
              },
              icon: BlocConsumer<UpdatePasswordCubic, UpdatePasswordState>(
                  builder: (_, state) {
                if (state is UpdatePasswordLoadingState) {
                  return const CupertinoActivityIndicator();
                }

                return const Icon(Icons.save);
              }, listener: (_, state) {
                print(state.toString());
                if (state is UpdatePasswordFailedState) {
                  StarlightUtils.pop();
                  StarlightUtils.dialog(AlertDialog(
                    title: Text(state.message),
                    actions: [
                      TextButton(
                          onPressed: () {
                            StarlightUtils.pop();
                          },
                          child: const Text("Ok"))
                    ],
                  ));
                }

                if (state is UpdatePasswordSucessState) {
                  StarlightUtils.pop();
                  StarlightUtils.dialog(AlertDialog(
                    title: const Text("Your Password is Saved"),
                    actions: [
                      TextButton(
                        child: const Text("Ok"),
                        onPressed: () {
                          StarlightUtils.pop();
                        },
                      )
                    ],
                  ));
                }
              })),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: bloc.formstate,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  onEditingComplete: () =>
                      bloc.passwordfocusNode.requestFocus(),
                  focusNode: bloc.focusNode,
                  controller: bloc.controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) {
                    final result = v?.isStrongPassword();
                    if (result != null) return result.toString();
                    if (v == null) return "Type your password";
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: "Type New Password"),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) {
                  final result = v?.isStrongPassword();
                  if (result != null) return result.toString();
                  if (v == null) return "Type your password";
                  return null;
                },
                controller: bloc.passwordcontroller,
                focusNode: bloc.passwordfocusNode,
                decoration: const InputDecoration(
                  label: Text("Type Current Your Password"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
