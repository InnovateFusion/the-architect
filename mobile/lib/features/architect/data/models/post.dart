import '../../domains/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required String id,
    required String title,
    required String content,
    required String userId,
    required String firstName,
    required String lastName,
    required DateTime date,
    required String image,
    required bool isLiked,
    required int like,
    required bool isCloned,
    required int clone,
    required List<String> tags,
    required String userImage,
  }) : super(
          id: id,
          title: title,
          content: content,
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          date: date,
          image: image,
          isLiked: isLiked,
          like: like,
          isCloned: isCloned,
          clone: clone,
          tags: tags,
          userImage: userImage,

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
        image: json['image'],
        isLiked: json['isLiked'],
        like: json['like'],
        isCloned: json['isCloned'],
        userImage: json['userImage'],
        clone: json['clone'],
        tags: json['tags'] != null ? List<String>.from(json['tags']) : []);
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
      'image': image,
      'isLiked': isLiked,
      'like': like,
      'isCloned': isCloned,
      'userImage': userImage,
      'clone': clone,
      'tags': tags,
    };
  }
}
