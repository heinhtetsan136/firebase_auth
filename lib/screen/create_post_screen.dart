import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:login_logout/controller/note_create/note_create_cubic.dart';
import 'package:login_logout/controller/note_create/note_create_state.dart';
import 'package:rich_editor/rich_editor.dart';
import 'package:starlight_utils/starlight_utils.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NoteCubit>();
    final bool editable = (bloc.note?.userid == bloc.user.currentUser?.uid);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(bloc.note == null
                ? "Create Note"
                : bloc.note!.editable || editable
                    ? "Editable"
                    : bloc.note!.title),
            actions: bloc.note == null || editable
                ? [
                    IconButton(
                        onPressed: () {
                          bloc.save();
                        },
                        icon: const Icon(Icons.save))
                  ]
                : null,
          ),
          body: Column(
            children: [
              if (bloc.note == null || editable) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    onTapOutside: (_) {
                      bloc.focusNode.unfocus();
                    },
                    controller: bloc.titleController,
                    focusNode: bloc.focusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    // validator: (v) =>
                    //     v?.isNotEmpty == true ? null : "Title is required",
                    decoration: const InputDecoration(
                        hintText: "Title",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                if (bloc.note?.userid == bloc.user.currentUser?.uid ||
                    bloc.note == null)
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    width: context.width,
                    child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                        value: bloc.acl,
                        items: ["Public", "Private", "Public-Read"]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          bloc.acl = value;
                          bloc.focusNode.unfocus();
                        }),
                  ),
                Expanded(
                  child: RichEditor(
                    value: bloc.html,
                    // value: "Content",
                    getImageUrl: (file) async {
                      final path = "note/${DateTime.now().toString()}";
                      await bloc.storage.ref(path).putFile(file);
                      return bloc.storage.ref(path).getDownloadURL();
                    },
                    key: bloc.formkey,
                    editorOptions: RichEditorOptions(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        // padding: const EdgeInsets.all(20),
                        enableVideo: false,
                        barPosition: BarPosition.BOTTOM),
                  ),
                ),
              ] else ...[
                HtmlWidget(bloc.note!.description),
              ]
            ],
          ),

          // body: ,
        ),
        BlocConsumer<NoteCubit, NoteCreateBaseState>(builder: (_, state) {
          if (state is! NoteCreateLoadingState) {
            return const SizedBox();
          } else {
            return Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(206, 200, 200, 0.298)),
                child: const Center(child: CircularProgressIndicator()));
          }
        }, listener: (_, state) {
          print(state);
          if (state is NoteCreateSucessState) {
            StarlightUtils.pop();
            StarlightUtils.dialog(AlertDialog(
              title: const Text("Your Note is Saved"),
              actions: [
                TextButton(
                    onPressed: () {
                      StarlightUtils.pop();
                    },
                    child: const Text("Ok")),
              ],
            ));
            // StarlightUtils.dialog(

            //     const SnackBar(content: Text("Your Note is Saved")));
          }
          if (state is NoteCreateFailedState) {
            StarlightUtils.dialog(AlertDialog(
              title: Text(state.error.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      StarlightUtils.pop();
                    },
                    child: const Text("Ok"))
              ],
            ));
          }
        })
      ],
    );
  }
}
