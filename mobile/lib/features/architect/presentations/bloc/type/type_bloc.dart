import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/type.dart'
    as type_entity;
import 'package:architect/features/architect/domains/use_cases/type/get.dart'
    as get_type;
import 'package:architect/features/architect/domains/use_cases/type/set.dart'
    as set_type;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/use_cases/usecase.dart';

part 'type_event.dart';
part 'type_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  TypeBloc({
    required this.getType,
    required this.setType,
  }) : super(TypeInitial()) {
    on<GetType>(_onGetType);
    on<SetType>(_onSetType);
  }

  final get_type.GetType getType;
  final set_type.SetType setType;

  Future<void> _onGetType(GetType event, Emitter<TypeState> emit) async {
    emit(TypeLoading());
    final failureOrType = await getType(NoParams());
    emit(
      failureOrType.fold(
        (failure) => TypeError(message: _mapFailureToMessage(failure)),
        (type) => TypeLoaded(model: type),
      ),
    );
  }

  Future<void> _onSetType(SetType event, Emitter<TypeState> emit) async {
    emit(TypeLoading());

    final failureOrType = await setType(set_type.Params(
      model: event.model,
    ));

    emit(
      failureOrType.fold(
        (failure) => TypeError(message: _mapFailureToMessage(failure)),
        (type) => TypeLoaded(model: type),
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
