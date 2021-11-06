import 'package:dartz/dartz.dart';
import 'package:movies_list/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
