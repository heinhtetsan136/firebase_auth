import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/Injection.dart';
import 'package:login_logout/controller/note_create/note_create_state.dart';
import 'package:login_logout/models/note_model.dart';
import 'package:login_logout/repositories/AuthService.dart';
import 'package:rich_editor/rich_editor.dart';

class NoteCubit extends Cubit<NoteCreateBaseState> {
  final NoteModel? note;
  NoteCubit(this.note) : super(const NoteCreateInitialState()) {
    if (note == null) return;
    titleController.text = note!.title;
    acl = note!.acl;
    html = note!.description;
  }
  final GlobalKey<RichEditorState> formkey = GlobalKey<RichEditorState>();
  final db = Injection<FirebaseFirestore>();
  final TextEditingController titleController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final AuthService user = Injection<AuthService>();
  String acl = "Private";
  String html = "";
  @override
  Future<void> close() {
    titleController.dispose();
    focusNode.dispose();
    // TODO: implement close
    return super.close();
  }

  final storage = Injection<FirebaseStorage>();
  Future<void> save() async {
    if (state is NoteCreateLoadingState) return;
    emit(const NoteCreateLoadingState());
    try {
      final html = await formkey.currentState?.getHtml();
      // db.collection("/note").doc().set({"html": html});

      final doc = db.collection("/note").doc(this.note?.id);
      final NoteModel note = NoteModel(
          userid: user.currentUser!.uid,
          id: doc.id,
          title: titleController.text,
          acl: acl,
          description: html ?? "");
      await doc.set(note.toJson(), SetOptions(merge: true)
          // SetOptions(mergeFields: [
          //   "title",
          //   if (this.note?.userid == note.userid) "acl",
          //   "description"
          // ])
          // SetOptions(mergeFields: [
          //   "title",
          //   if (this.note?.userid == note.userid) "acl",
          //   "description"
          // ]));
          );
      emit(const NoteCreateSucessState());
    } on FirebaseException catch (e) {
      emit(NoteCreateFailedState(e.message.toString()));
    } catch (e) {
      emit(NoteCreateFailedState(e.toString()));
    }
  }
}
