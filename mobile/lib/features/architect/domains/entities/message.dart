import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.sender,
    required this.date,
    required this.content,
  });

  final String id;
  final String sender;
  final DateTime date;
  final Map<String, dynamic> content;

  @override
  List<Object?> get props => [
        id,
        sender,
        date,
        content,
      ];
}
