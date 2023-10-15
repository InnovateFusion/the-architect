import 'package:equatable/equatable.dart';

class Chat extends Equatable {

  const Chat({
    required this.id,
    required this.title,
    required this.userId,
    required this.messages,
  });

  final String id;
  final String title;
  final String userId;
  final List<String> messages;


  @override
  List<Object?> get props => [
        id,
        title,
        userId,
        messages,
      ];
}