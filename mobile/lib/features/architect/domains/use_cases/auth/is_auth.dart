import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../repositories/auth.dart';

class CheckAuth extends UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuth(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkAuth();
  }
}
