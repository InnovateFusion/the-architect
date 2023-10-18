import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/repositories/auth.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/use_cases/usecase.dart';

class CheckAuth extends UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuth(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkAuth();
  }
}
