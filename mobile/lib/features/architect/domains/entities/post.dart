import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.content,
    required this.image,
    required this.like,
    required this.clone,
    required this.date,
    required this.userId,
    required this.isLiked,
    required this.isCloned,
    required this.tags,
    required this.userImage,
  });

  final String id;
  final String title;
  final String content;
  final String image;
  final int like;
  final int clone;
  final DateTime date;
  final String userId;
  final bool isLiked;
  final bool isCloned;
  final List<String> tags;
  final String firstName;
  final String lastName;
  final String userImage;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        image,
        like,
        clone,
        date,
        userId,
        isLiked,
        isCloned,
        tags,
        firstName,
        lastName,
        userImage,
      ];

  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? image,
    int? like,
    int? clone,
    DateTime? date,
    String? userId,
    bool? isLiked,
    bool? isCloned,
    List<String>? tags,
    String? firstName,
    String? lastName,
    String? userImage,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      like: like ?? this.like,
      clone: clone ?? this.clone,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      isLiked: isLiked ?? this.isLiked,
      isCloned: isCloned ?? this.isCloned,
      tags: tags ?? this.tags,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userImage: userImage ?? this.userImage,
    );
  }
}
