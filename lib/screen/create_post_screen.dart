import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/controller/note_create/note_create_cubic.dart';
import 'package:rich_editor/rich_editor.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NoteCreateCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        actions: [
          IconButton(
              onPressed: () {
                bloc.save();
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: RichEditor(
        key: bloc.formkey,
        editorOptions:
            RichEditorOptions(enableVideo: false, barPosition: BarPosition.TOP),
      ),

      // body: ,
    );
  }
}
