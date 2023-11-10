import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domains/entities/chat.dart';
import '../../domains/entities/message.dart';
import '../../domains/repositories/chat.dart';
import '../datasources/local/auth.dart';
import '../datasources/remote/chat.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  final AuthLocalDataSource authLocalDataSource;

  ChatRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, Chat>> view(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final chat = await remoteDataSource.viewChat(id, auth.accessToken);
        return Right(chat);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Chat>> create(
      {required Map<String, dynamic> payload,
      required String userId,
      required String model}) async {
    if (await networkInfo.isConnected) {
      final auth = await authLocalDataSource.getToken();
      try {
        final chat = await remoteDataSource.create(
            model: model,
            payload: payload,
            userId: userId,
            token: auth.accessToken);
        print('chat $chat');

        return Right(chat);
      } on ServerException {
        print('err');
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Chat>>> views(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final chats =
            await remoteDataSource.viewChats(userId, auth.accessToken);
        return Right(chats);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Message>> message({
    required Map<String, dynamic> payload,
    required String chatId,
    required String userId,
    required String model,
    bool? isTeam,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final chat = await remoteDataSource.message(
            model: model,
            payload: payload,
            chatId: chatId,
            token: auth.accessToken,
            userId: userId,
            isTeam: isTeam ?? false);
        print('chat $chat');
        return Right(chat);
      } on ServerException {
        print(' eorrrrrrrrrr       ');
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Chat>> delete(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final chat = await remoteDataSource.delete(id, auth.accessToken);
        return Right(chat);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
