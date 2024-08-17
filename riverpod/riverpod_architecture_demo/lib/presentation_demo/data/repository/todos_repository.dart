import 'package:riverpod_architecture_demo/presentation_demo/domain/model/todo.dart';

class TodosRepository {
  List<Todo> todos = [];

  Future<List<Todo>> getAll() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    return todos;
  }

  Future<void> add(Todo newTodo) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    todos.add(newTodo);
  }
}
