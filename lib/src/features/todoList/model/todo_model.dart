import 'package:clean_framework/clean_framework.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          isCompleted == other.isCompleted &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      isCompleted.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    final deserializer = Deserializer(json);
    return TodoModel(
      id: deserializer.getString('_id'),
      title: deserializer.getString('title'),
      description: deserializer.getString('description'),
      isCompleted: deserializer.getBool('is_completed'),
      createdAt: deserializer.getString('created_at'),
      updatedAt: deserializer.getString('updated_at'),
    );
  }
}
