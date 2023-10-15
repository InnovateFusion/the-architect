import 'package:architect/features/architect/domains/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required String id,
    required String title,
    required String content,
    required String userId,
    required String firstName,
    required String lastName,
    required DateTime date,
    required String userImage,
    required String image,
    required bool isLiked,
    required int like,
    required bool isCloned,
    required int clone,
    required List<String> tags,
  }) : super(
          id: id,
          title: title,
          content: content,
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          date: date,
          userImage: userImage,
          image: image,
          isLiked: isLiked,
          like: like,
          isCloned: isCloned,
          clone: clone,
          tags: tags,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      date: DateTime.parse(json['date']),
      userImage: json['userImage'],
      image: json['image'],
      isLiked: json['isLiked'],
      like: json['like'],
      isCloned: json['isCloned'],
      clone: json['clone'],
      tags: json['tags'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'date': date.toIso8601String(),
      'userImage': userImage,
      'image': image,
      'isLiked': isLiked,
      'like': like,
      'isCloned': isCloned,
      'clone': clone,
      'tags': tags,
    };
  }
}
