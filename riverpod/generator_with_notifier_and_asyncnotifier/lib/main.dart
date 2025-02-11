import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generator_with_notifier_and_asyncnotifier/async_notifier_counter/async_counter_page.dart';
import 'package:generator_with_notifier_and_asyncnotifier/async_value_practice/json_fetch_page.dart';
import 'package:generator_with_notifier_and_asyncnotifier/simple_counter/simple_counter.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("simple counter"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CounterWidget(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("json fetch"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const JsonFetchPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("async counter"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AsyncCounterPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
