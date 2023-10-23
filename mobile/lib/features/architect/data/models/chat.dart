import 'dart:convert';

import '../../domains/entities/chat.dart';
import '../../domains/entities/message.dart';
import 'message.dart';

class ChatModel extends Chat {
  const ChatModel({
    required String id,
    required String title,
    required String userId,
    required List<Message> messages,
  }) : super(
          id: id,
          title: title,
          userId: userId,
          messages: messages,
        );

  factory ChatModel.fromJson(Map<String, dynamic> jsonData) {
    List<Message> messages = [];
    for (var message in jsonData['messages']) {
      messages.add(MessageModel.fromJson(json.decoder.convert(message)));
    }

    return ChatModel(
      id: jsonData['id'],
      title: jsonData['title'],
      userId: jsonData['user_id'],
      messages: messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'messages': messages,
    };
  }
}
