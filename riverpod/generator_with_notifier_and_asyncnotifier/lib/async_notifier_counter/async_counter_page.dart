import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generator_with_notifier_and_asyncnotifier/async_notifier_counter/generated_async_counter.dart';
// import 'package:generator_with_notifier_and_asyncnotifier/async_notifier_counter/async_counter.dart';

class AsyncCounterPage extends ConsumerWidget {
  const AsyncCounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(asyncCounterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('async counter')),
      body: Center(
        child: counter.when(
          data: (value) =>
              Text(value.toString(), style: TextStyle(fontSize: 60)),
          error: (_, __) => const Text("error"),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(asyncCounterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
