import 'package:architect/core/use_cases/usecase.dart';
import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:architect/features/architect/domains/repositories/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

class ViewUsers implements UseCase<List<User>, NoParams> {
  final UserRepository repository;

  const ViewUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.views();
  }
}
