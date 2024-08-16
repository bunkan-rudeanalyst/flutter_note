import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter.dart';

// 基本となるStateProviderを使った例

// final counterProvider = StateProvider<int>((ref) => 0);

// class CounterWidget extends ConsumerWidget {
//   const CounterWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // providerの参照
//     final counter = ref.watch(counterProvider);

//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           // provider取得した値を表示
//           child: Text('$counter'),
//           // providerのstateを更新
//           onPressed: () => ref.read(counterProvider.notifier).state++,
//         ),
//       ),
//     );
//   }
// }

// Notifierを使った例
// class CounterNotifier extends Notifier<int> {
//   @override
//   build() {
//     // 初期値
//     // Notifier<データ型>のデータ型の値をreturnする
//     return 0;
//   }

//   // stateを変更して状態を更新するメソッド
//   void increment() {
//     // stateがNotiferが扱う状態を表す
//     state++;
//   }
// }

// final counterProvider = NotifierProvider<CounterNotifier, int>(() {
//   return CounterNotifier();
// });
// final counterProvider =
//     NotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // providerの参照
    // final counter = ref.watch(counterProvider);
    final counter = ref.watch(counterProvider);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          // provider取得した値を表示
          child: Text('$counter'),
          // Notifierで定義したメソッドを呼び出す
          onPressed: () => ref.read(counterProvider.notifier).increment(),
        ),
      ),
    );
  }
}
