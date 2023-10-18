import 'package:architect/core/errors/failure.dart';
import 'package:architect/core/network/network_info.dart';
import 'package:architect/features/architect/data/datasources/local/user.dart';
import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../domains/repositories/user.dart';
import '../datasources/local/auth.dart';
import '../datasources/remote/user.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> create({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? image,
    String? bio,
    String? country,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.createUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          image: image,
          bio: bio,
          country: country,
        );
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> update({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? password,
    String? image,
    String? bio,
    String? country,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUser = await remoteDataSource.updateUser(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password ?? '',
          token: token.accessToken,
          image: image,
          bio: bio,
          country: country,
        );
        localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> delete(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUser =
            await remoteDataSource.deleteUser(id, token.accessToken);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> view(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUser =
            await remoteDataSource.viewUser(id, token.accessToken);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> me() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUsers = await remoteDataSource.meUser(token.accessToken);
        return Right(remoteUsers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> follow(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUser =
            await remoteDataSource.followUser(id, token.accessToken);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> unfollow(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUser =
            await remoteDataSource.unfollowUser(id, token.accessToken);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> followers(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUsers =
            await remoteDataSource.followersUser(id, token.accessToken);
        return Right(remoteUsers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> followings(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authLocalDataSource.getToken();
        final remoteUsers =
            await remoteDataSource.followingUser(id, token.accessToken);
        return Right(remoteUsers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
