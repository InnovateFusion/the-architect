part of 'team_bloc.dart';

sealed class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

final class TeamCreateEvent extends TeamEvent {
  const TeamCreateEvent({
    required this.title,
    this.description,
    this.image,
    this.members,
  });

  final String title;
  final String? description;
  final String? image;
  final List<String>? members;

  @override
  List<Object> get props => [
        title,
      ];
}

final class TeamViewsEvent extends TeamEvent {
  const TeamViewsEvent();
}

final class TeamUpdateEvent extends TeamEvent {
  const TeamUpdateEvent({
    required this.id,
    required this.title,
    this.description,
    this.image,
    this.members,
  });

  final String id;
  final String title;
  final String? description;
  final String? image;
  final List<String>? members;

  @override
  List<Object> get props => [
        id,
        title,
      ];
}

final class TeamDeleteEvent extends TeamEvent {
  const TeamDeleteEvent({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [
        id,
      ];
}

final class TeamViewEvent extends TeamEvent {
  const TeamViewEvent({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [
        id,
      ];
}

final class TeamJoinEvent extends TeamEvent {
  const TeamJoinEvent({
    required this.teamId,
    required this.userId,
  });

  final String teamId;
  final String userId;

  @override
  List<Object> get props => [
        teamId,
        userId,
      ];
}

final class TeamLeaveEvent extends TeamEvent {
  const TeamLeaveEvent({
    required this.teamId,
    required this.userId,
  });

  final String teamId;
  final String userId;

  @override
  List<Object> get props => [
        teamId,
        userId,
      ];
}

final class TeamMemberAddsEvent extends TeamEvent {
  const TeamMemberAddsEvent({
    required this.teamId,
    required this.userId,
  });

  final String teamId;
  final List<String> userId;

  @override
  List<Object> get props => [
        teamId,
        userId,
      ];
}

final class TeamMembersEvent extends TeamEvent {
  const TeamMembersEvent({
    required this.teamId,
  });

  final String teamId;

  @override
  List<Object> get props => [
        teamId,
      ];
}
