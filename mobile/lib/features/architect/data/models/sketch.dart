import '../../domains/entities/sketch.dart';

class SketchModel extends Sketch {
  const SketchModel({required String id, required String title})
      : super(id: id, title: title);

  factory SketchModel.fromJson(Map<String, dynamic> json) {
    return SketchModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
