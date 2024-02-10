import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:rich_editor/rich_editor.dart';

class NoteCreateCubit extends Cubit<bool> {
  NoteCreateCubit() : super(false);
  final GlobalKey<RichEditorState> formkey = GlobalKey<RichEditorState>();
  final db = Injection<FirebaseFirestore>();
  Future<void> save() async {
    final html = await formkey.currentState?.getHtml();
    db.collection("/note").doc().set({"html": html});
  }
}
