// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AsyncCounter extends AutoDisposeAsyncNotifier<int> {
//   // AsyncNotifierクラスないでは
//   // どこでもrefが参照できる
//   @override
//   FutureOr<int> build() {
//     // 初期値
//     return 0;
//   }

//   Future<void> increment() async {
//     state = const AsyncLoading();
//     state = await Future.delayed(
//       // インクリメントするたびに1秒waitを入れた
//       const Duration(seconds: 1),
//       () => AsyncValue.data(state.value! + 1),
//     );
//   }
// }

// // providerインスタンス
// // autoDispose: 全てのproviderのリスナーが削除された際、自動で状態をリセットする
// final asyncCounterProvider =
//     AsyncNotifierProvider.autoDispose<AsyncCounter, int>(AsyncCounter.new);
