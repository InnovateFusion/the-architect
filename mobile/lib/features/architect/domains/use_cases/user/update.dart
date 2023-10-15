import 'package:architect/core/errors/failure.dart';
import 'package:architect/core/use_cases/usecase.dart';
import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:architect/features/architect/domains/repositories/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UserUpdate implements UseCase<User, Params> {
  final UserRepository repository;

  const UserUpdate(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.update(
      id: params.id,
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
      image: params.image,
      bio: params.bio,
      country: params.country,
    );
  }
}

class Params extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final String? image;
  final String? bio;
  final String? country;

  const Params({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    this.image,
    this.bio,
    this.country,
  });

  @override
  List<Object?> get props =>
      [firstName, lastName, email, password, image, bio, country];
}
