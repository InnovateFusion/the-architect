part of 'sketch_bloc.dart';

sealed class SketchEvent extends Equatable {
  const SketchEvent();

  @override
  List<Object> get props => [];
}

class SketchEventCreate extends SketchEvent {
  final String title;
  final String teamId;

  const SketchEventCreate({
    required this.title,
    required this.teamId,
  });

  @override
  List<Object> get props => [title, teamId];
}

class SketchEventUpdate extends SketchEvent {
  final String sketchId;
  final String title;
  final String teamId;

  const SketchEventUpdate({
    required this.sketchId,
    required this.title,
    required this.teamId,
  });

  @override
  List<Object> get props => [sketchId, title, teamId];
}

class SketchEventDelete extends SketchEvent {
  final String sketchId;

  const SketchEventDelete({
    required this.sketchId,
  });

  @override
  List<Object> get props => [sketchId];
}


class SketchEventView extends SketchEvent {
  final String sketchId;

  const SketchEventView({
    required this.sketchId,
  });

  @override
  List<Object> get props => [sketchId];
}

class SketchEventViews extends SketchEvent {
  final String teamId;

  const SketchEventViews({
    required this.teamId,
  });

  @override
  List<Object> get props => [teamId];
}