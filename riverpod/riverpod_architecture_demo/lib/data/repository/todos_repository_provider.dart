import 'package:riverpod_architecture_demo/data/repository/todos_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  return TodosRepository();
});
