import 'package:architect/features/architect/domains/entities/user.dart';
import '../../../../core/errors/failure.dart';
import '../entities/team.dart';
import 'package:dartz/dartz.dart';

abstract class TeamRepository {
  
  Future<Either<Failure, Team>> create({
  required String title,
  String? description,
  String? image,
  List<String>? members,
  });
  
  Future<Either<Failure, Team>> update({
  required String title,
  required String teamId,
  List<String>? members,
  String? description,
  String? image,
  });

  Future<Either<Failure, List<Team>>> views();
  
  Future<Either<Failure, Team>> view(String id);
  Future<Either<Failure, Team>> delete(String id);
  Future<Either<Failure, Team>> join(String teamId, String userId);
  Future<Either<Failure, Team>> leave(String teamId, String userId);
  Future<Either<Failure, Team>> addUsers(List<String> usersId, String teamId);
  Future<Either<Failure, List<User>>> teamMembers(String teamId);
}
