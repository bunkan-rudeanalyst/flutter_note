// 1. import this
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 2. declare a part file
part 'generated_async_counter.g.dart';

@riverpod
class AsyncCounter extends _$AsyncCounter {
  @override
  Future<int> build() async {
    return await Future.delayed(Duration(seconds: 1), () => 0);
  }

  Future<void> increment() async {
    state = const AsyncValue.loading();
    await Future.delayed(Duration(seconds: 1), () {
      state = AsyncValue.data(state.value! + 1);
    });
  }
}
