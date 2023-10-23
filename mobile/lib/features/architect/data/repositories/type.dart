import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/local/type.dart';
import '../../domains/entities/type.dart';
import '../../domains/repositories/type.dart';
import 'package:dartz/dartz.dart';

class TypeRepositoryImpl extends TypeRepository {
  TypeRepositoryImpl({
    required this.localDataSource,
  });

  final TypeLocalDataSource localDataSource;

  @override
  Future<Either<Failure, Type>> getType() async {
    try {
      final type = await localDataSource.getType();
      return Right(type);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Type>> setType(String model) async {
    try {
      final type = await localDataSource.cacheTypes(model);
      return Right(type);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
