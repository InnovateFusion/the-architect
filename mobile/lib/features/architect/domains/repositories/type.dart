import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/type.dart';

abstract class TypeRepository {
  Future<Either<Failure, Type>> getType();
  Future<Either<Failure, Type>> setType(String model);
}
