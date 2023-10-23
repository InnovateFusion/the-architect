part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class ChatViewEvent extends ChatEvent {
  const ChatViewEvent({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

final class ChatViewsEvent extends ChatEvent {
  const ChatViewsEvent({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [userId];
}

final class ChatCreateEvent extends ChatEvent {
  const ChatCreateEvent({
    required this.payload,
    required this.userId,
    required this.model,
  });

  final Map<String, dynamic> payload;
  final String userId;
  final String model;

  @override
  List<Object> get props => [payload, userId, model];
}


final class MakeChatEvent extends ChatEvent {
  const MakeChatEvent({
    required this.userId,
    required this.payload,
    required this.chatId,
    required this.model,
  });

  final Map<String, dynamic> payload;
  final String chatId;
  final String model;
  final String userId;

  @override
  List<Object> get props => [payload, chatId, model, userId];
}