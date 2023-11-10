import 'package:equatable/equatable.dart';

class Sketch extends Equatable {
  const Sketch({required this.id, required this.title});

  final String id;
  final String title;

  @override
  List<Object?> get props => [
        id,
        title,
      ];

  Sketch copyWith({
    String? id,
    String? title,
  }) {
    return Sketch(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
