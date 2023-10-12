import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../model/todo_model.dart';
import '../presentation/todo_list_view_model.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final TodoModel todo;
  final TodoListViewModel viewModel;

  const TodoCard({
    super.key,
    required this.index,
    required this.todo,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final randomColor = Colors.primaries[index % Colors.primaries.length];
    return Card(
      child: ListTile(
        leading:
            CircleAvatar(backgroundColor: randomColor, child: const Text('')),
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              context.router.push(
                Routes.todoForm,
                extra: {
                  'id': todo.id,
                  'title': todo.title,
                  'description': todo.description,
                  'isCompleted': todo.isCompleted
                },
              );
            } else if (value == 'delete') {
              deleteAlert(context);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              )
            ];
          },
        ),
      ),
    );
  }

  Future<dynamic> deleteAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you sure you want to delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  viewModel.deleteById(todo.id);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          );
        });
  }
}
