import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domains/entities/team.dart';
import '../../domains/repositories/team.dart';
import '../datasources/local/auth.dart';
import '../datasources/remote/team.dart';

class TeamRepositoryImpl extends TeamRepository {
  TeamRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.authLocalDataSource,
  });

  final TeamRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, Team>> addUsers(List<String> usersId, String teamId) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.addUsers(usersId, auth.accessToken, teamId);
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Team>> create(
      {required String title, String? description, String? image,  List<String>? members}) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.create(
            title: title,
            description: description,
            image: image,
            token: auth.accessToken,
            members: members
            );
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Team>> delete(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.delete(id, auth.accessToken);
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Team>> join(String teamId, String userId) async{
        if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.join(teamId, userId, auth.accessToken);
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Team>> leave(String teamId, String userId) async{
        if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.leave(teamId, userId, auth.accessToken);
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> teamMembers(String teamId) async {
        if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.teamMembers(teamId, auth.accessToken);
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Team>> update(
      {required String title, required String teamId,  String? description, String? image, List<String>? members }) async{
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.update(
            teamId: teamId,
            title: title,
            description: description,
            image: image,
            members: members,
            token: auth.accessToken);
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }


  }

  @override
  Future<Either<Failure, Team>> view(String id) async{
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final team = await remoteDataSource.view(id, auth.accessToken);
        return Right(team);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Team>>> views() async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();

        final teams = await remoteDataSource.views(auth.accessToken);
        return Right(teams);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
