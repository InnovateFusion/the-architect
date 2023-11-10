import 'package:equatable/equatable.dart';

class Team extends Equatable {
  const Team({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorId,
    required this.firstName,
    required this.lastName,
    required this.creatorImage,
    required this.createAt,
    required this.image,
  });

  final String id;
  final String title;
  final String description;
  final String creatorId;
  final String firstName;
  final String lastName;
  final String creatorImage;
  final String createAt;
  final String image;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        creatorId,
        firstName,
        lastName,
        creatorImage,
        createAt,
        image,
      ];

  Team copyWith({
    String? id,
    String? title,
    String? description,
    String? creatorId,
    String? firstName,
    String? lastName,
    String? creatorImage,
    String? createAt,
    String? image,
  }) {
    return Team(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      creatorImage: creatorImage ?? this.creatorImage,
      createAt: createAt ?? this.createAt,
      image: image ?? this.image,
    );
  }
}
