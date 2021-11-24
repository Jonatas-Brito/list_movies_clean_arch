import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {
  ServerFailure() : super(properties: []);
}

class CachedToRemoveFailure extends Failure {
  CachedToRemoveFailure() : super(properties: []);
}

class CachedToAddFailure extends Failure {
  CachedToAddFailure() : super(properties: []);
}

class CachedToRetriveFailure extends Failure {
  CachedToRetriveFailure() : super(properties: []);
}

class UnconnectedDevice extends Failure {
  UnconnectedDevice() : super(properties: []);
}

class SearchFailure extends Failure {
  SearchFailure() : super(properties: []);
}

class ErrorCheckMovie extends Failure {
  ErrorCheckMovie() : super(properties: []);
}
