import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String image;
  final int like;
  final bool isLike;
  final bool clone;
  final bool isCloned;
  final int userId;
  final String date;
  final String username;
  final String userImage;

  const Post({
    required this.id,
    required this.image,
    required this.like,
    required this.isLike,
    required this.clone,
    required this.isCloned,
    required this.userId,
    required this.date,
    required this.username,
    required this.userImage,
  });

  @override
  List<Object?> get props {
    return [
      id,
      image,
      like,
      isLike,
      clone,
      isCloned,
      userId,
      date,
      username,
      userImage,
    ];
  }
}
