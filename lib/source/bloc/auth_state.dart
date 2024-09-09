import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User user;
  AuthLoggedInState(this.user);
}

class AuthLoggedOutState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}

class AuthCodeSentState extends AuthState {}

class AuthCodeVerifiedState extends AuthState {}
