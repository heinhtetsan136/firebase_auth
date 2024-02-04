import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/update_email/update_email_bloc.dart';
import 'package:login_logout/controller/update_email/update_email_state.dart';
import 'package:starlight_utils/starlight_utils.dart';

class UpdateEmail extends StatelessWidget {
  const UpdateEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateEmailCubic>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Email"),
        actions: [
          IconButton(
              onPressed: () {
                bloc.UpdateEmail(bloc.controller.text);
              },
              icon: BlocConsumer<UpdateEmailCubic, UpdateEmailState>(
                  builder: (_, state) {
                if (state is UpdateEmailLoadingState) {
                  return const CupertinoActivityIndicator();
                }

                return const Icon(Icons.save);
              }, listener: (_, state) {
                print(state.toString());
                if (state is UpdateEmailFailedState) {
                  StarlightUtils.pop();
                  StarlightUtils.dialog(AlertDialog(
                    title: Text(state.message!),
                    actions: [
                      TextButton(
                          onPressed: () {
                            StarlightUtils.pop();
                          },
                          child: const Text("Ok"))
                    ],
                  ));
                }

                if (state is UpdateEmailSucessState) {
                  StarlightUtils.pop();
                  StarlightUtils.dialog(AlertDialog(
                    title: const Text("Your Email is Saved"),
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
                  validator: (v) => v?.isNotEmpty == true
                      ? v?.isEmail == true
                          ? null
                          : "Invalid Email"
                      : "Email is required",
                  decoration: const InputDecoration(labelText: "New Email"),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) =>
                    v?.isNotEmpty == true ? null : "Password is requried",
                controller: bloc.passwordcontroller,
                focusNode: bloc.passwordfocusNode,
                decoration: const InputDecoration(
                  label: Text("Type Your Password"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
