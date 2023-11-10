import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user.dart';

class ViewUsers implements UseCase<List<User>, NoParams> {
  final UserRepository repository;

  const ViewUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.views();
  }
}
