part of 'sketch_bloc.dart';

enum SketchstatusAll { initial, loading, success, failure }

enum SketchStatus { initial, loading, success, failure }

class SketchState extends Equatable {
  const SketchState({
    this.statusAll = SketchstatusAll.initial,
    this.sketches = const <Sketch>[],
    this.statusSketch = SketchStatus.initial,
    this.sketch,
  });

  final SketchstatusAll statusAll;
  final List<Sketch> sketches;
  final SketchStatus statusSketch;
  final Sketch? sketch;

  @override
  List<Object> get props => [
        statusAll,
        sketches,
        statusSketch,
      ];

  SketchState copyWith({
    SketchstatusAll? statusAll,
    List<Sketch>? sketches,
    SketchStatus? statusSketch,
    Sketch? sketch,
  }) {
    return SketchState(
      statusAll: statusAll ?? this.statusAll,
      sketches: sketches ?? this.sketches,
      statusSketch: statusSketch ?? this.statusSketch,
      sketch: sketch ?? this.sketch,
    );
  }


  @override
  String toString() {
  
    
    return '''SketchState(
      statusAll: $statusAll,
      sketches: $sketches,
      statusSketch: $statusSketch,
      sketch: $sketch,
    )''';
  }


  
}
