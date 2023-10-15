import 'package:architect/features/architect/domains/entities/message.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  const Chat({
    required this.id,
    required this.title,
    required this.userId,
    required this.messages,
    required this.date,
  });

  final String id;
  final String title;
  final String userId;
  final DateTime date;
  final List<Message> messages;

  @override
  List<Object?> get props => [
        id,
        title,
        userId,
        messages,
        date,
      ];
}
