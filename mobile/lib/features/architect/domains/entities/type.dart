import 'package:equatable/equatable.dart';

class Type extends Equatable {
  const Type({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}
