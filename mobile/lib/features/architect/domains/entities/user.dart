import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.bio,
    required this.country,
    required this.followers,
    required this.following,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final String bio;
  final String country;
  final int followers;
  final int following;


  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        image,
        bio,
        country,
        followers,
        following,
      ];
}
