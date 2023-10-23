import '../../domains/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required String id,
    required String sender,
    required DateTime date,
    required String content,
  }) : super(
          id: id,
          sender: sender,
          date: date,
          content: content,
        );
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['id'],
        sender: json['sender'],
        date: DateTime.parse(json['date']),
        content: json['content']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'date': date,
      'content': content,
    };
  }
}
