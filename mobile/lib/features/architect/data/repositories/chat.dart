import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domains/entities/chat.dart';
import '../../domains/entities/message.dart';
import '../../domains/repositories/chat.dart';
import '../datasources/remote/chat.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Chat>> view(String id) async {
    if (await networkInfo.isConnected) {
      try {
        String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjM3OTg1OTUwNTEyLCJlbWFpbCI6ImRldkBiaXNyYXQudGVjaCIsImlkIjoiMzVhNzBmZGYtN2Q3ZC00ZjJmLWE5N2MtNWUxZWViNWJjMzNhIiwiZmlyc3RfbmFtZSI6ImJpc3JhdCIsImxhc3RfbmFtZSI6ImtlYmVyZSJ9._7f9ZvPC28c04P6rt_Pt60KRHUANR3hN5eQYPpuVSfY";
        final chat = await remoteDataSource.viewChat(id, token);
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
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjM3OTg1OTUwNTEyLCJlbWFpbCI6ImRldkBiaXNyYXQudGVjaCIsImlkIjoiMzVhNzBmZGYtN2Q3ZC00ZjJmLWE5N2MtNWUxZWViNWJjMzNhIiwiZmlyc3RfbmFtZSI6ImJpc3JhdCIsImxhc3RfbmFtZSI6ImtlYmVyZSJ9._7f9ZvPC28c04P6rt_Pt60KRHUANR3hN5eQYPpuVSfY";
      try {
        final chat = await remoteDataSource.create(
            model: model, payload: payload, userId: userId, token: token);
        return Right(chat);
      } on ServerException {
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
        String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjM3OTg1OTUwNTEyLCJlbWFpbCI6ImRldkBiaXNyYXQudGVjaCIsImlkIjoiMzVhNzBmZGYtN2Q3ZC00ZjJmLWE5N2MtNWUxZWViNWJjMzNhIiwiZmlyc3RfbmFtZSI6ImJpc3JhdCIsImxhc3RfbmFtZSI6ImtlYmVyZSJ9._7f9ZvPC28c04P6rt_Pt60KRHUANR3hN5eQYPpuVSfY";
        final chats = await remoteDataSource.viewChats(userId, token);
        return Right(chats);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Message>> message(
      {required Map<String, dynamic> payload,
      required String chatId,
      required String userId,
      required String model}) async {
    if (await networkInfo.isConnected) {
      try {
        String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjM3OTg1OTUwNTEyLCJlbWFpbCI6ImRldkBiaXNyYXQudGVjaCIsImlkIjoiMzVhNzBmZGYtN2Q3ZC00ZjJmLWE5N2MtNWUxZWViNWJjMzNhIiwiZmlyc3RfbmFtZSI6ImJpc3JhdCIsImxhc3RfbmFtZSI6ImtlYmVyZSJ9._7f9ZvPC28c04P6rt_Pt60KRHUANR3hN5eQYPpuVSfY";
        final chat = await remoteDataSource.message(
            model: model,
            payload: payload,
            chatId: chatId,
            token: token,
            userId: userId);
        return Right(chat);
      } on ServerException {
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
        String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjM3OTg1OTUwNTEyLCJlbWFpbCI6ImRldkBiaXNyYXQudGVjaCIsImlkIjoiMzVhNzBmZGYtN2Q3ZC00ZjJmLWE5N2MtNWUxZWViNWJjMzNhIiwiZmlyc3RfbmFtZSI6ImJpc3JhdCIsImxhc3RfbmFtZSI6ImtlYmVyZSJ9._7f9ZvPC28c04P6rt_Pt60KRHUANR3hN5eQYPpuVSfY";
        final chat = await remoteDataSource.delete(id, token);
        return Right(chat);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
