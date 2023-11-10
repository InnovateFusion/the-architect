part of 'team_bloc.dart';

enum TeamstatusAll { initial, loading, success, failure }

enum TeamStatus { initial, loading, success, failure }

enum TeamMember { initial, loading, success, failure }

class TeamState extends Equatable {
  const TeamState({
    this.statusAll = TeamstatusAll.initial,
    this.teams = const <Team>[],
    this.statusTeam = TeamStatus.initial,
    this.team,
    this.users = const <User>[],
    this.statusMember = TeamMember.initial,
  });

  final TeamstatusAll statusAll;
  final List<Team> teams;
  final TeamStatus statusTeam;
  final Team? team;
  final List<User> users;
  final TeamMember statusMember;

  TeamState copyWith({
    TeamstatusAll? statusAll,
    List<Team>? teams,
    TeamStatus? statusTeam,
    Team? team,
    List<User>? users,
    TeamMember? statusMember,
  }) {
    return TeamState(
      statusAll: statusAll ?? this.statusAll,
      teams: teams ?? this.teams,
      statusTeam: statusTeam ?? this.statusTeam,
      team: team ?? this.team,
      users: users ?? this.users,
      statusMember: statusMember ?? this.statusMember,
    );
  }

  @override
  String toString() {
    return '''TeamState(
      statusAll: $statusAll,
      teams: $teams,
      statusTeam: $statusTeam,
      team: $team,
      users: $users,
      statusMember: $statusMember,

    )''';
  }

  @override
  List<Object> get props => [
        statusAll,
        teams,
        statusTeam,
        users,
        statusMember,
      ];
}
