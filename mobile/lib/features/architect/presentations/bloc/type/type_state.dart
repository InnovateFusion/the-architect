part of 'type_bloc.dart';

sealed class TypeState extends Equatable {
  const TypeState();

  @override
  List<Object> get props => [];
}

final class TypeInitial extends TypeState {}

final class TypeLoading extends TypeState {}

final class TypeLoaded extends TypeState {
  const TypeLoaded({
    required this.model,
  });

  final type_entity.Type model;

  @override
  List<Object> get props => [
        model,
      ];
}

final class TypeError extends TypeState {
  const TypeError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
