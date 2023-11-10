import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domains/entities/sketch.dart';
import '../../../domains/use_cases/sketch/create.dart' as create_sketch;
import '../../../domains/use_cases/sketch/delete.dart' as delete_sketch;
import '../../../domains/use_cases/sketch/update.dart' as update_sketch;
import '../../../domains/use_cases/sketch/view.dart' as view_sketch;
import '../../../domains/use_cases/sketch/views.dart' as views_sketch;

part 'sketch_event.dart';
part 'sketch_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SketchBloc extends Bloc<SketchEvent, SketchState> {
  SketchBloc({
    required this.create,
    required this.update,
    required this.delete,
    required this.view,
    required this.views,
  }) : super(const SketchState()) {
    on<SketchEventCreate>(_onCreateSketch,
        transformer: throttleDroppable(throttleDuration));
    on<SketchEventUpdate>(_onUpdateSketch,
        transformer: throttleDroppable(throttleDuration));
    on<SketchEventDelete>(_onDeleteSketch,
        transformer: throttleDroppable(throttleDuration));
    on<SketchEventView>(_onViewSketch,
        transformer: throttleDroppable(throttleDuration));
    on<SketchEventViews>(_onViewsSketch,
        transformer: throttleDroppable(throttleDuration));
  }

  final create_sketch.SketchCreate create;
  final update_sketch.SketchUpdate update;
  final delete_sketch.SketchDelete delete;
  final view_sketch.SketchView view;
  final views_sketch.SketchViews views;

  Future<void> _onCreateSketch(
    SketchEventCreate event,
    Emitter<SketchState> emit,
  ) async {
    emit(state.copyWith(statusSketch: SketchStatus.loading));
    final result = await create(create_sketch.Params(
      title: event.title,
      teamId: event.teamId,
    ));
    result.fold(
      (failure) => emit(state.copyWith(statusSketch: SketchStatus.failure)),
      (sketch) {
        List<Sketch> array = [...state.sketches, sketch];
        emit(state.copyWith(
          statusSketch: SketchStatus.success,
          sketch: sketch,
          sketches: array,
        ));
      },
    );
  }

  Future<void> _onUpdateSketch(
    SketchEventUpdate event,
    Emitter<SketchState> emit,
  ) async {
    emit(state.copyWith(statusSketch: SketchStatus.loading));
    final result = await update(update_sketch.Params(
      sketchId: event.sketchId,
      title: event.title,
      teamId: event.teamId,
    ));
    result.fold(
      (failure) => emit(state.copyWith(statusSketch: SketchStatus.failure)),
      (sketch) => emit(state.copyWith(
        statusSketch: SketchStatus.success,
        sketch: sketch,
      )),
    );
  }

  Future<void> _onDeleteSketch(
    SketchEventDelete event,
    Emitter<SketchState> emit,
  ) async {
    emit(state.copyWith(statusSketch: SketchStatus.loading));
    final result = await delete(delete_sketch.Params(
      sketchId: event.sketchId,
    ));
    result.fold(
      (failure) => emit(state.copyWith(statusSketch: SketchStatus.failure)),
      (sketch) {
        List<Sketch> array = [...state.sketches];
        array.removeWhere((element) => element.id == sketch.id);
        emit(state.copyWith(
          statusSketch: SketchStatus.success,
          sketch: sketch,
          sketches: array,
          statusAll: SketchstatusAll.success,
        ));
      },
    );
  }

  Future<void> _onViewSketch(
    SketchEventView event,
    Emitter<SketchState> emit,
  ) async {
    emit(state.copyWith(statusSketch: SketchStatus.loading));
    final result = await view(view_sketch.Params(
      sketchId: event.sketchId,
    ));
    result.fold(
      (failure) => emit(state.copyWith(statusSketch: SketchStatus.failure)),
      (sketch) => emit(state.copyWith(
        statusSketch: SketchStatus.success,
        sketch: sketch,
      )),
    );
  }

  Future<void> _onViewsSketch(
    SketchEventViews event,
    Emitter<SketchState> emit,
  ) async {
    emit(state.copyWith(statusAll: SketchstatusAll.loading));
    final result = await views(views_sketch.Params(teamId: event.teamId));
    result.fold(
      (failure) => emit(state.copyWith(statusAll: SketchstatusAll.failure)),
      (sketches) => emit(state.copyWith(
        statusAll: SketchstatusAll.success,
        sketches: sketches,
      )),
    );
  }
}
