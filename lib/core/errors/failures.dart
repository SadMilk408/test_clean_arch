import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  String get error => '';
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure{
  final String message;
  ServerFailure({required this.message});
  @override
  String get error => message;
}

class CacheFailure extends Failure{
  final String message;
  CacheFailure({required this.message});
  @override
  String get error => message;
}

class UnAuthFailure extends Failure{
  final String message;
  UnAuthFailure({required this.message});
  @override
  String get error => message;
}

class ConnectionFailure extends Failure{
  final String message;
  ConnectionFailure({required this.message});
  @override
  String get error => message;
}
