import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/sketch.dart';
import '../../repositories/sketch.dart';

class SketchCreate extends UseCase<Sketch, Params> {
  final SketchRepository repository;

  SketchCreate(this.repository);

  @override
  Future<Either<Failure, Sketch>> call(Params params) async {
    return await repository.create(
      title: params.title,
      teamId: params.teamId,
    );
  }
}

class Params extends Equatable {
  final String title;
  final String teamId;

  const Params({required this.title, required this.teamId});

  @override
  List<Object?> get props => [teamId, title];
}
