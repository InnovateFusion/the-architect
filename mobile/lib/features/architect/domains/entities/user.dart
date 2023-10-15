import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.image,
    required this.bio,
    required this.country,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String image;
  final String bio;
  final String country;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        image,
        bio,
        country,
      ];
}
