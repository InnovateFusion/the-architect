import 'package:architect/core/errors/exception.dart';
import 'package:architect/features/architect/domains/entities/sketch.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domains/repositories/sketch.dart';
import '../datasources/local/auth.dart';
import '../datasources/remote/sketch.dart';

class SketchRepositoryImpl implements SketchRepository {
  SketchRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  final RemoteSketchDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Sketch>> create({
    required String title,
    required String teamId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final sketch = await remoteDataSource.create(
            title: title, teamId: teamId, token: auth.accessToken);
        return Right(sketch);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sketch>> delete(String sketchId) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final sketch = await remoteDataSource.delete(
            sketchId: sketchId, token: auth.accessToken);
        return Right(sketch);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sketch>> update(
      {required String sketchId,
      required String title,
      required String teamId}) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final sketch = await remoteDataSource.update(
            sketchId: sketchId,
            title: title,
            teamId: teamId,
            token: auth.accessToken);

        return Right(sketch);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sketch>> view(String sketchId) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final sketch = await remoteDataSource.view(sketchId, auth.accessToken);
        return Right(sketch);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Sketch>>> views({required String teamId}) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final sketches = await remoteDataSource.views(
            teamId: teamId, token: auth.accessToken);
        return Right(sketches);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
