import 'package:clean_framework/clean_framework.dart';

enum TodoFormTags { title, description, isCompleted }

enum TodoFormStatus { initial, loading, loaded, failed }

class TodoFormEntity extends Entity {
  final TodoFormStatus status;
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;
  final FormController formController;

  const TodoFormEntity({
    this.id = '',
    this.status = TodoFormStatus.initial,
    this.title = '',
    this.description = '',
    this.isCompleted = false,
    this.createdAt = '',
    this.updatedAt = '',
    required this.formController,
  });

  @override
  List<Object?> get props => [
        status,
        id,
        title,
        description,
        isCompleted,
        createdAt,
        updatedAt,
        formController,
      ];

  @override
  TodoFormEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? createdAt,
    String? updatedAt,
    TodoFormStatus? status,
    FormController? formController,
  }) {
    return TodoFormEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      formController: formController ?? this.formController,
    );
  }
}
