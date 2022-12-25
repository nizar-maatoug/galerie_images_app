part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticatedState extends AuthState {
  final String message;
  AuthenticatedState({required this.message});

  @override
  List<Object> get props => [message];
}

class UnAuthenticatedState extends AuthState {
  final String message;
  UnAuthenticatedState({required this.message});

  @override
  List<Object> get props => [message];
}


class LoginProgressState extends AuthState{

}

class LogOutInProgressState extends AuthState{

}



