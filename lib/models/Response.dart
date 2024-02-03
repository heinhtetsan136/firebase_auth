import 'package:firebase_auth/firebase_auth.dart';

class Response {
  final String? error;
  final User? data;
  bool get isError => error != null;

  Response({this.error, this.data});
  @override
  String toString() {
    // TODO: implement toString
    if (error != null) {
      return error.toString();
    }
    return data.toString();
  }
}
