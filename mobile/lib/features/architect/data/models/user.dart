import '../../domains/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? bio,
    String? image,
    String? country,
    int? followers,
    int? following,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          bio: bio ?? '',
          image: image ?? '',
          country: country ?? '',
          followers: followers ?? 0,
          following: following ?? 0,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      bio: json['bio'],
      image: json['image'],
      country: json['country'],
      followers: json['followers'],
      following: json['following'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'bio': bio,
      'image': image,
      'country': country,
      'followers': followers,
      'following': following,
    };
  }
}
