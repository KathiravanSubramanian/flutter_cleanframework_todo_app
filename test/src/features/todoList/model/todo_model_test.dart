import 'package:flutter_cleanframework_todo_app/src/features/todoList/model/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final todo1 = TodoModel(
      id: '1',
      title: 'Task 1',
      description: 'Task 1',
      isCompleted: false,
      createdAt: '',
      updatedAt: '');
  final todo2 = TodoModel(
      id: '2',
      title: 'Task 2',
      description: 'Task 2',
      isCompleted: false,
      createdAt: '',
      updatedAt: '');
  final todo3 = TodoModel(
      id: '1',
      title: 'Task 1',
      description: 'Task 1',
      isCompleted: false,
      createdAt: '',
      updatedAt: '');

  group('TodoModel Equality Test', () {
    test('Two TodoModel instances with the same id should be equal', () {
      expect(todo1, equals(todo3));
    });

    test('Two TodoModel instances with different ids should not be equal', () {
      expect(todo1, isNot(equals(todo2)));
    });
  });

  group('TodoModel HashCode Test', () {
    test(
        'Two TodoModel instances with the same id should have the same hashCode',
        () {
      expect(todo1.hashCode, equals(todo3.hashCode));
    });

    test(
        'Two TodoModel instances with different ids should have different hashCodes',
        () {
      expect(todo1.hashCode, isNot(equals(todo2.hashCode)));
    });
  });
}
