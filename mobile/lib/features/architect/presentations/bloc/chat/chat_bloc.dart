import 'package:architect/features/architect/domains/use_cases/chat/create.dart'
    as chat_create;
import 'package:architect/features/architect/domains/use_cases/chat/message.dart'
    as chat_message;
import 'package:architect/features/architect/domains/use_cases/chat/view.dart'
    as chat_view;
import 'package:architect/features/architect/domains/use_cases/chat/views.dart'
    as chat_views;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domains/entities/chat.dart';
import '../../../domains/entities/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.chatView,
    required this.chatViews,
    required this.chatCreate,
    required this.chatMessage,
  }) : super(ChatInitial()) {
    on<ChatViewEvent>(_onChatView);
    on<ChatViewsEvent>(_onChatViews);
    on<ChatCreateEvent>(_onChatCreate);
    on<MakeChatEvent>(_onChatMessage);
  }

  final chat_create.CreateChat chatCreate;
  final chat_view.ViewChat chatView;
  final chat_views.ViewsChat chatViews;
  final chat_message.MakeChat chatMessage;

  Future<void> _onChatView(ChatViewEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final failureOrChat = await chatView(chat_view.Params(
      id: event.id,
    ));
    emit(
      failureOrChat.fold(
        (failure) => ChatError(message: _mapFailureToMessage(failure)),
        (chat) => ChatViewLoaded(chat: chat),
      ),
    );
  }

  Future<void> _onChatViews(
      ChatViewsEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final failureOrChats = await chatViews(chat_views.Params(
      id: event.userId,
    ));
    emit(
      failureOrChats.fold(
        (failure) => ChatError(message: _mapFailureToMessage(failure)),
        (chats) => ChatViewsLoaded(chats: chats),
      ),
    );
  }

  Future<void> _onChatCreate(
      ChatCreateEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final failureOrChat = await chatCreate(chat_create.Params(
      payload: event.payload,
      userId: event.userId,
      model: event.model,
    ));
    emit(
      failureOrChat.fold(
        (failure) => ChatError(message: _mapFailureToMessage(failure)),
        (chat) => ChatCreateLoaded(chat: chat),
      ),
    );
  }

  Future<void> _onChatMessage(
      MakeChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final failureOrMessage = await chatMessage(chat_message.Params(
      payload: event.payload,
      chatId: event.chatId,
      model: event.model,
      userId: event.userId,
    ));
    emit(
      failureOrMessage.fold(
        (failure) => ChatError(message: _mapFailureToMessage(failure)),
        (message) => MakeChatLoaded(message: message),
      ),
    );
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
