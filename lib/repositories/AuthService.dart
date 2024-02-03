import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_logout/models/Response.dart';
import 'package:starlight_utils/starlight_utils.dart';

class AuthService {
  final FirebaseAuth _auth;
  User? currentUser;
  StreamSubscription? _userSubscription;
  final StreamController _authStateController = StreamController.broadcast();
  Stream get authState => _authStateController.stream;
  AuthService() : _auth = FirebaseAuth.instance {
    _userSubscription = _auth.userChanges().listen((user) {
      _authStateController.sink.add(user);
      currentUser = user;
    });
  }
  void dispose() {
    _userSubscription?.cancel();
    _authStateController.close();
  }

  Response? _validate(String email, String password) {
    if (!email.isEmail) {
      return Response(error: "Email is invalid");
    }
    final result = password.isStrongPassword();
    if (result != null) {
      return Response(error: result);
    }
    return null;
  }

  Future<Response> _try(Future<Response> Function() callback) async {
    try {
      final result = await callback();
      return result;
    } on FirebaseAuthException catch (e) {
      return Response(error: e.message);
    } catch (e) {
      return Response(error: "Unknown error");
    }
  }

  // static AuthService? _instance;
  // factory AuthService.instance(){
  //   _instance ??=AuthService._();
  //   return _instance!;
  Future<Response> register(String email, String password) async {
    return await _try(() async {
      final validate = _validate(email, password);
      if (validate != null) {
        return validate;
      }
      final UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Response(data: user.user);
    });
  }

  Future<Response> login(String email, String password) async {
    return await _try(() async {
      final UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Response(data: user.user);
    });
  }

  Future<Response> singout() async {
    return await _try(() async {
      await _auth.signOut();
      return Response();
    });
  }

  Future<Response> reset(String email) async {
    return await _try(() async {
      await _auth.sendPasswordResetEmail(email: email);
      return Response();
    });
  }
}
