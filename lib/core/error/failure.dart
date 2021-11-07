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

class UnconnectedDevice extends Failure {
  UnconnectedDevice() : super(properties: []);
}
