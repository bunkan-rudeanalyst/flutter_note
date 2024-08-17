import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_architecture_demo/presentation_demo/domain/model/todo.dart';
import 'package:riverpod_architecture_demo/presentation_demo/presentation/controller/todos_page_controller.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> todosState =
        ref.watch(todosPageControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Demo'),
      ),
      body: todosState.when(
        data: (data) => data.isEmpty
            ? const Center(
                child: Text('Todoがありません'),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(data[index].title),
                      trailing: Text('#${data[index].id}'),
                    )),
        error: (_, __) => const Center(
          child: Text('エラーが発生しました'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Text('追加'),
          onPressed: () async {
            await ref.read(todosPageControllerProvider.notifier).addTodo();
          }),
    );
  }
}
