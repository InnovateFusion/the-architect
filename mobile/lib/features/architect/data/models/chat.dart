import 'package:architect/features/architect/domains/entities/chat.dart';
import 'package:architect/features/architect/domains/entities/message.dart';

class ChatModel extends Chat {
  const ChatModel({
    required String id,
    required String title,
    required String userId,
    required DateTime date,
    required List<Message> messages,
  }) : super(
          id: id,
          title: title,
          userId: userId,
          date: date,
          messages: messages,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      messages: json['messages'].cast<Message>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'date': date,
      'messages': messages,
    };
  }
}
