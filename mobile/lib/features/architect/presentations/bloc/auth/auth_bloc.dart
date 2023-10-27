import 'package:architect/features/architect/domains/use_cases/auth/get_token.dart'
    as get_auth;
import 'package:architect/features/architect/domains/use_cases/auth/is_auth.dart'
    as check_auth;
import 'package:architect/features/architect/domains/use_cases/auth/delete.dart'
    as delete_auth;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../../domains/entities/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final get_auth.GetToken getToken;
  final check_auth.CheckAuth checkAuth;
  final delete_auth.DeleteAuth deleteAuth;

  AuthBloc({
    required this.getToken,
    required this.checkAuth,
    required this.deleteAuth,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>(_onGetToken);
    on<AuthCheckEvent>(_onCheckAuth);
    on<AuthLogoutEvent>(_onLogout);
    add(AuthCheckEvent());
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  Future<void> _onGetToken(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth = await getToken(get_auth.Params(
      email: event.email,
      password: event.password,
    ));
    emit(
      failureOrAuth.fold(
          (failure) => AuthError(message: _mapFailureToMessage(failure)),
          (auth) => Authenticated(auth: auth)),
    );
  }

  Future<void> _onCheckAuth(
      AuthCheckEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth = await checkAuth(NoParams());
    emit(
      failureOrAuth.fold(
        (failure) => AuthInitial(),
        (auth) => Authenticated(
          auth: auth,
        ),
      ),
    );
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth = await deleteAuth(NoParams());
    emit(
      failureOrAuth.fold(
        (failure) => AuthError(message: _mapFailureToMessage(failure)),
        (auth) => AuthLoggedOut(),
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
