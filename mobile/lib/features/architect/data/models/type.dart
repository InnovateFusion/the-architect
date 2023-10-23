import '../../domains/entities/type.dart';

class TypeModel extends Type {
  const TypeModel({
    required String name,
  }) : super(
          name: name,
        );

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
