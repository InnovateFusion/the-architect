import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
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
      ];
 
}