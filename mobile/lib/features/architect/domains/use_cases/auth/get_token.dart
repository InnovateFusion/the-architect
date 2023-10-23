import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/auth.dart';
import '../../repositories/auth.dart';

class GetToken extends UseCase<Auth, Params> {
  final AuthRepository repository;

  GetToken(this.repository);

  @override
  Future<Either<Failure, Auth>> call(Params params) async {
    return await repository.getAuth(
      email: params.email,
      password: params.password,
    );
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
