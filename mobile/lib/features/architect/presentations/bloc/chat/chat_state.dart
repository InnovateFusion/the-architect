part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatViewLoaded extends ChatState {
  const ChatViewLoaded({
    required this.chat,
  });

  final Chat chat;

  @override
  List<Object> get props => [chat];
}

final class ChatViewsLoaded extends ChatState {
  const ChatViewsLoaded({
    required this.chats,
  });

  final List<Chat> chats;

  @override
  List<Object> get props => [chats];
}

final class ChatError extends ChatState {
  const ChatError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}


final class ChatCreateLoaded extends ChatState {
  const ChatCreateLoaded({
    required this.chat,
  });

  final Chat chat;

  @override
  List<Object> get props => [chat];
}

final class MakeChatLoaded extends ChatState {
  const MakeChatLoaded({
    required this.message,
  });

  final Message message;

  @override
  List<Object> get props => [message];
}

