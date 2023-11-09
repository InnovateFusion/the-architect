import '../../domains/entities/team.dart';

class TeamModel extends Team {
  const TeamModel({
    required String id,
    required String title,
    required String description,
    required String creatorId,
    required String firstName,
    required String lastName,
    required String creatorImage,
    required String createAt,
    required String image,
  }) : super(
          id: id,
          title: title,
          description: description,
          creatorId: creatorId,
          firstName: firstName,
          lastName: lastName,
          creatorImage: creatorImage,
          createAt: createAt,
          image: image,
        );

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        creatorId: json['creator_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        creatorImage: json['creator_image'],
        createAt: json['create_at'],
        image: json['image']
        
        );


        
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'firstName': firstName,
      'lastName': lastName,
      'creatorImage': creatorImage,
      'createAt': createAt,
      'image': image,
    };
  }
}

