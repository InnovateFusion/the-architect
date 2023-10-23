import 'package:equatable/equatable.dart';

import 'message.dart';

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
  final List<Message> messages;

  @override
  List<Object?> get props => [
        id,
        title,
        userId,
        messages,
      ];
}
