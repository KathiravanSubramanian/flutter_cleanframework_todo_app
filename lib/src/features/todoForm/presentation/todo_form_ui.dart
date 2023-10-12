import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import '../domain/todo_form_entity.dart';
import '../widgets/fields.dart';
import 'todo_form_presenter.dart';
import 'todo_form_view_model.dart';

class TodoFormUI extends UI<TodoFormViewModel> {
  TodoFormUI({super.key, required this.selectedTodo});

  final Map<String, dynamic> selectedTodo;

  @override
  TodoFormPresenter create(WidgetBuilder builder) {
    return TodoFormPresenter(
      builder: builder,
      selectedTodo: selectedTodo,
    );
  }

  @override
  Widget build(BuildContext context, TodoFormViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedTodo['id'] == '' ? 'Add' : 'Edit'),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: InputForm(
                controller: viewModel.formController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const TextInputField(
                        tag: TodoFormTags.title,
                        hintText: 'Title',
                        focus: true,
                      ),
                      const SizedBox(height: 20),
                      const TextInputField(
                        tag: TodoFormTags.description,
                        hintText: 'Description',
                      ),
                      const SizedBox(height: 20),
                      FormButton(
                        onPressed: () {
                          if (selectedTodo['id'] == '') {
                            viewModel.createTodo();
                          } else {
                            viewModel.updateById(selectedTodo['id']);
                          }
                        },
                        child:
                            Text(selectedTodo['id'] == '' ? 'Add' : 'Update'),
                      ),
                    ],
                  ),
                )),
          ),
          if (viewModel.isLoading)
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}
