import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/core.dart';
import '../../../routes/routes.dart';
import '../widgets/todo_card.dart';
import 'todo_list_presenter.dart';
import 'todo_list_view_model.dart';

class TodoListUI extends UI<TodoListViewModel> {
  TodoListUI({super.key});

  @override
  TodoListPresenter create(WidgetBuilder builder) {
    return TodoListPresenter(builder: builder);
  }

  @override
  Widget build(BuildContext context, viewModel) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          centerTitle: false,
        ),
        body: Stack(
          children: [
            todoList(viewModel, context),
            if (viewModel.isLoading)
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.router.push(
                Routes.todoForm,
                extra: {
                  'id': '',
                  'title': '',
                  'description': '',
                  'isCompleted': false
                },
              );
            },
            child: const Icon(Icons.add)));
  }

  Widget noDataFound(TodoListViewModel viewModel, BuildContext context) {
    if (!viewModel.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.empty),
            const SizedBox(height: 20),
            Text('Things look empty here. Tap + to add',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  SafeArea todoList(TodoListViewModel viewModel, BuildContext context) {
    return SafeArea(
      child: Visibility(
        visible: viewModel.todoList.isNotEmpty,
        replacement: noDataFound(viewModel, context),
        child: RefreshIndicator(
          onRefresh: () async {
            await viewModel.onRefresh();
          },
          child: ListView.builder(
            itemCount: viewModel.todoList.length,
            itemBuilder: (context, index) {
              final todo = viewModel.todoList[index];
              return TodoCard(index: index, todo: todo, viewModel: viewModel);
            },
          ),
        ),
      ),
    );
  }
}
