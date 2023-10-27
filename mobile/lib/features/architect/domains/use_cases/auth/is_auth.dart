import 'package:architect/features/architect/domains/entities/auth.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../repositories/auth.dart';

class CheckAuth extends UseCase<Auth, NoParams> {
  final AuthRepository repository;

  CheckAuth(this.repository);

  @override
  Future<Either<Failure, Auth>> call(NoParams params) async {
    return await repository.checkAuth();
  }
}
