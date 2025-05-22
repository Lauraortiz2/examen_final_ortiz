import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormProvider extends ChangeNotifier{

GlobalKey<FormState> formKey = new GlobalKey<FormState>();

String email = '';
String password = '';
String errorMessage = '';
bool _isLoading = false;
 bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isLogged = false;
  bool get isLogged => _isLogged;
  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  String mailGuardado = '';
  String passwordGuardada = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    isLoading = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    } catch (error) {
      errorMessage = getMessageFromErrorCode(error);
      notifyListeners();
    }
  }

  //Método para identificarse en la app con email y contraseña.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    //isLoading = true;
    try {
      // ignore: unused_local_variable
      final user = await SharedPreferences.getInstance();
      mailGuardado = await user.getString('email') ?? '';
      passwordGuardada = await user.getString('password') ?? '';

      if(email == mailGuardado && password == passwordGuardada) _isLogged = true; 
    } catch (error) {
      errorMessage = getMessageFromErrorCode(error);
      notifyListeners();
    }
  }

  //Método para deslogearse de la app
  Future<void> signOut() async {
    email = '';
    password = '';
    _isLoading = false;
    _isLogged = false;
    notifyListeners();
  }

  String getMessageFromErrorCode(errorCode) {
    switch (errorCode.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      case "INVALID_LOGIN_CREDENTIALS":
        return "Invalid credentials.";
      default:
        return "Login failed. Please try again.";
    }
  }
}