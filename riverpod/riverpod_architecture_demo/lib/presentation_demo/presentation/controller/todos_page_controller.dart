import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_architecture_demo/presentation_demo/data/repository/todos_repository_provider.dart';
import 'package:riverpod_architecture_demo/presentation_demo/domain/model/todo.dart';

class TodoListPageController extends AsyncNotifier<List<Todo>> {
  @override
  FutureOr<List<Todo>> build() async {
    final todos = await ref.read(todosRepositoryProvider).getAll();
    return todos;
  }

  Future<void> addTodo() async {
    state = const AsyncLoading();
    final todosRepository = ref.read(todosRepositoryProvider);
    await todosRepository
        .add(Todo(title: 'new todo', id: Random().nextInt(100)));
    state = await AsyncValue.guard(todosRepository.getAll);
  }
}

final todosPageControllerProvider =
    AsyncNotifierProvider<TodoListPageController, List<Todo>>(
        TodoListPageController.new);
