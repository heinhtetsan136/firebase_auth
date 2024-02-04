import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/upade_username/update_username_cubic.dart';
import 'package:login_logout/controller/upade_username/update_username_state.dart';

import 'package:starlight_utils/starlight_utils.dart';

class UpdateUsername extends StatelessWidget {
  const UpdateUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateUserNameCubic>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Username"),
        actions: [
          IconButton(
              onPressed: () {
                bloc.UpdateUsername(bloc.controller.text);
              },
              icon: BlocConsumer<UpdateUserNameCubic, UpdateUserNameState>(
                  builder: (_, state) {
                if (state is UpdateUsernameLoadingState) {
                  return const CupertinoActivityIndicator();
                }

                return const Icon(Icons.save);
              }, listener: (_, state) {
                print(state.toString());
                if (state is UpdateUsernameFailedState) {
                  StarlightUtils.dialog(SnackBar(content: Text(state.message)));
                }

                if (state is UpdateUsernameSucessState) {
                  StarlightUtils.pop();
                  StarlightUtils.dialog(AlertDialog(
                    title: const Text("Your Name is Saved"),
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
              TextFormField(
                focusNode: bloc.focusNode,
                controller: bloc.controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) =>
                    v?.isNotEmpty == true ? null : "Username is requried",
                decoration: const InputDecoration(labelText: "Username"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
