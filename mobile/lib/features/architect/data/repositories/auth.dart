import 'package:architect/features/architect/domains/entities/auth.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/local/auth.dart';
import '../datasources/remote/auth.dart';
import '../datasources/remote/user.dart';
import '../models/auth.dart';
import '../../domains/repositories/auth.dart';
import 'package:dartz/dartz.dart';

import '../datasources/local/user.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
    required this.userRemoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthModel>> getAuth({
    required String email,
    required String password,
  }) async {
    late bool authisValid;
    try {
      await authLocalDataSource.isValid();
      authisValid = true;
    } on CacheException {
      authisValid = false;
    }
    if (!authisValid && await networkInfo.isConnected) {
      try {
        final remoteAuth = await remoteDataSource.login(
          email: email,
          password: password,
        );
        final token = remoteAuth.accessToken;
        final user = await userRemoteDataSource.meUser(token);
        await authLocalDataSource.cacheToken(remoteAuth);
        await localDataSource.cacheUser(user);
        return Right(remoteAuth);
      } on ServerException {
        return Left(ServerFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      try {
        return Right(await authLocalDataSource.getToken());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Auth>> checkAuth() async {
    try {
      final isValidToken = await authLocalDataSource.isValid();
      return Right(isValidToken);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAuth() async {
    try {
      await authLocalDataSource.deleteToken();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
