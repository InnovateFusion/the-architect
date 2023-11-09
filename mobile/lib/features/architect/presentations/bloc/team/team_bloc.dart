import 'package:architect/core/use_cases/usecase.dart';
import 'package:architect/features/architect/domains/entities/team.dart';
import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:architect/features/architect/domains/use_cases/team/add_member.dart'
    as add_member;
import 'package:architect/features/architect/domains/use_cases/team/create.dart'
    as create_team;
import 'package:architect/features/architect/domains/use_cases/team/delete.dart'
    as delete_team;
import 'package:architect/features/architect/domains/use_cases/team/join.dart'
    as join_team;
import 'package:architect/features/architect/domains/use_cases/team/leave.dart'
    as leave_team;
import 'package:architect/features/architect/domains/use_cases/team/member.dart'
    as member_team;
import 'package:architect/features/architect/domains/use_cases/team/update.dart'
    as update_team;
import 'package:architect/features/architect/domains/use_cases/team/view.dart'
    as view_team;
import 'package:architect/features/architect/domains/use_cases/team/views.dart'
    as views_team;
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../../core/errors/failure.dart';

part 'team_event.dart';
part 'team_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final create_team.TeamCreate create;
  final views_team.TeamViews views;
  final view_team.TeamView view;
  final update_team.TeamUpdate update;
  final member_team.TeamMembers member;
  final delete_team.TeamDelete delete;
  final leave_team.TeamLeave leave;
  final join_team.TeamJoin join;
  final add_member.TeamAddMembers addMember;

  TeamBloc({
    required this.create,
    required this.views,
    required this.view,
    required this.update,
    required this.member,
    required this.delete,
    required this.leave,
    required this.join,
    required this.addMember,
  }) : super(const TeamState()) {
    on<TeamCreateEvent>(_onCreateTeam,
        transformer: throttleDroppable(throttleDuration));
    on<TeamViewsEvent>(_onViewsEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TeamViewEvent>(_onViewEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TeamUpdateEvent>(_onUpdateEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TeamMembersEvent>(_onMembersEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TeamDeleteEvent>(_onDeleteEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TeamLeaveEvent>(_onLeaveEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TeamJoinEvent>(_onJoinEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TeamMemberAddsEvent>(_onAddMembersEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onCreateTeam(
      TeamCreateEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusTeam: TeamStatus.loading));

    final failureOrType = await create(create_team.Params(
      title: event.title,
      description: event.description,
      image: event.image,
      members: event.members,
    ));

    emit(
      failureOrType.fold(
        (failure) => state.copyWith(
          statusTeam: TeamStatus.failure,
          team: null,
        ),
        (type) => state.copyWith(
          statusTeam: TeamStatus.success,
          team: type,
        ),
      ),
    );
  }

  Future<void> _onViewsEvent(
      TeamViewsEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusAll: TeamstatusAll.loading));

    final failureOrType = await views(NoParams());
    emit(
      failureOrType.fold(
        (failure) => state.copyWith(
          statusAll: TeamstatusAll.failure,
          teams: [],
        ),
        (type) => state.copyWith(
          statusAll: TeamstatusAll.success,
          teams: type,
        ),
      ),
    );
  }

  Future<void> _onViewEvent(
      TeamViewEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusTeam: TeamStatus.loading));

    final failureOrType = await view(view_team.Params(teamId: event.id));
    emit(
      failureOrType.fold(
        (failure) => state.copyWith(
          statusTeam: TeamStatus.failure,
          team: null,
        ),
        (type) => state.copyWith(
          statusTeam: TeamStatus.success,
          team: type,
        ),
      ),
    );
  }

  Future<void> _onUpdateEvent(
      TeamUpdateEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusTeam: TeamStatus.loading));

    final failureOrType = await update(update_team.Params(
      teamId: event.id,
      title: event.title,
      description: event.description,
      image: event.image,
      members: event.members,
    ));

    emit(
      failureOrType.fold(
          (failure) => state.copyWith(
                statusTeam: TeamStatus.failure,
                team: null,
              ), (type) {
        List<Team> teams = state.teams;

        for (var i = 0; i < state.teams.length; i++) {
          if (state.teams[i].id == type.id) {
            teams[i] = type;
          }
        }

        return state.copyWith(
          statusTeam: TeamStatus.success,
          team: type,
          teams: teams,
        );
      }),
    );
  }

  Future<void> _onMembersEvent(
      TeamMembersEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusMember: TeamMember.loading));

    final failureOrType = await member(member_team.Params(event.teamId));
    emit(
      failureOrType.fold(
        (failure) => state.copyWith(
          statusMember: TeamMember.failure,
          users: [],
        ),
        (type) => state.copyWith(
          statusMember: TeamMember.success,
          users: type,
        ),
      ),
    );
  }

  Future<void> _onDeleteEvent(
      TeamDeleteEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusTeam: TeamStatus.loading));

    final failureOrType = await delete(delete_team.Params(teamId: event.id));
    emit(
      failureOrType.fold(
          (failure) => state.copyWith(
                statusTeam: TeamStatus.failure,
                team: null,
              ), (type) {
        List<Team> teams = state.teams;
        teams.removeWhere((element) => element.id == event.id);
        return state.copyWith(
          statusTeam: TeamStatus.success,
          team: type,
          teams: teams,
        );
      }),
    );
  }

  Future<void> _onLeaveEvent(
      TeamLeaveEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusTeam: TeamStatus.loading));

    final failureOrType = await leave(leave_team.Params(
      teamId: event.teamId,
      userId: event.userId,
    ));

    emit(
      failureOrType.fold(
          (failure) => state.copyWith(
                statusTeam: TeamStatus.failure,
                team: null,
              ), (type) {
        List<Team> teams = state.teams;
        teams.removeWhere((element) => element.id == event.teamId);
        return state.copyWith(
          statusTeam: TeamStatus.success,
          team: type,
          teams: teams,
        );
      }),
    );
  }

  Future<void> _onJoinEvent(
      TeamJoinEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusTeam: TeamStatus.loading));

    final failureOrType = await join(join_team.Params(
      teamId: event.teamId,
      userId: event.userId,
    ));

    emit(
      failureOrType.fold(
          (failure) => state.copyWith(
                statusTeam: TeamStatus.failure,
                team: null,
              ), (type) {
        List<Team> teams = state.teams;
        teams.removeWhere((element) => element.id == event.teamId);
        return state.copyWith(
          statusTeam: TeamStatus.success,
          team: type,
          teams: teams,
        );
      }),
    );
  }

  Future<void> _onAddMembersEvent(
      TeamMemberAddsEvent event, Emitter<TeamState> emit) async {
    emit(state.copyWith(statusTeam: TeamStatus.loading));

    final failureOrType = await addMember(add_member.Params(
      teamId: event.teamId,
      usersId: event.userId,
    ));

    emit(
      failureOrType.fold(
          (failure) => state.copyWith(
                statusTeam: TeamStatus.failure,
                team: null,
              ), (type) {
        List<Team> teams = state.teams;
        teams.removeWhere((element) => element.id == event.teamId);
        return state.copyWith(
          statusTeam: TeamStatus.success,
          team: type,
          teams: teams,
        );
      }),
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
