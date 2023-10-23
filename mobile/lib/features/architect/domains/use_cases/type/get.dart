import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/type.dart';
import '../../repositories/type.dart';

class GetType extends UseCase<Type, NoParams> {
  final TypeRepository repository;

  GetType(this.repository);

  @override
  Future<Either<Failure, Type>> call(NoParams params) async {
    return await repository.getType();
  }
}
