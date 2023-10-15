import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/auth.dart';
import 'package:architect/features/architect/domains/repositories/auth.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/use_cases/usecase.dart';

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
