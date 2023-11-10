import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/sketch.dart';

abstract class SketchRepository {
  Future<Either<Failure, Sketch>> create({
    required String title,
    required String teamId,
  });
  Future<Either<Failure, Sketch>> update({
    required String sketchId,
    required String title,
    required String teamId,
  });

  Future<Either<Failure, List<Sketch>>> views({
    required String teamId,
  });
  Future<Either<Failure, Sketch>> view(String sketchId);
  Future<Either<Failure, Sketch>> delete(String sketchId);
}
