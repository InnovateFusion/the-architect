part of 'type_bloc.dart';

sealed class TypeEvent extends Equatable {
  const TypeEvent();

  @override
  List<Object> get props => [];
}

final class GetType extends TypeEvent {}

final class SetType extends TypeEvent {
  const SetType({
    required this.model,
  });

  final String model;

  @override
  List<Object> get props => [
        model,
      ];
}
