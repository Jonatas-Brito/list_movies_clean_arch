import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class FailureGetMovies implements Failure {
  @override
  String get message => 'erro';

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}
