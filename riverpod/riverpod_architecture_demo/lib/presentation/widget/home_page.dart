import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_architecture_demo/presentation/widget/todo_list_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Application demo'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodoListPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
