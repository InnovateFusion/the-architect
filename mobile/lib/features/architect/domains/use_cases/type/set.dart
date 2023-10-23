import '../../../../../core/errors/failure.dart';
import '../../entities/type.dart';
import '../../repositories/type.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/use_cases/usecase.dart';

class SetType extends UseCase<Type, Params> {
  final TypeRepository repository;

  SetType(this.repository);

  @override
  Future<Either<Failure, Type>> call(Params params) async {
    return await repository.setType(params.model);
  }
}

class Params extends Equatable {
  const Params({
    required this.model,
  });

  final String model;

  @override
  List<Object?> get props => [
        model,
      ];
}
