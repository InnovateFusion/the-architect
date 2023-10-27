import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../repositories/auth.dart';

class DeleteAuth extends UseCase<void, NoParams> {
  final AuthRepository repository;

  DeleteAuth(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteAuth();
  }
}
