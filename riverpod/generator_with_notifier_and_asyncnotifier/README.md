# generator_with_notifier_and_asyncnotifier

https://codewithandrea.com/articles/flutter-riverpod-async-notifier/

## セットアップ

以下のコマンドを実行して必要なパッケージをインストールする。

```sh
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:build_runner
flutter pub add dev:custom_lint
flutter pub add dev:riverpod_lint
```

providerを参照したいウィジェットをProviderScopeでラップする。

```dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

## generator

riverpod_generatorがProviderの生成を自動で行ってくれる。
実行にはbuild_runnerを利用する。

https://pub.dev/packages/riverpod_generator

generatorツールの起動は以下のコマンドを実行する。

```sh
flutter pub run build_runner watch
```

もしバックグラウンドでコマンドを実行したい場合`-d`オプションをつける。

```sh
flutter pub run build_runner watch -d
```

## Notifier, AsyncNotifierとは

StateNotifierの代替となるクラス。
以下の特徴がある。

- 簡単に非同期初期化ができる
- `riverpod_generator`を使うとProviderを自動で作成可能

## StateProvider vs NotifierProvider

### StateProvider:
シンプルな値には向いており、複雑なロジックには不向き。

```dart
// Providerの定義
final Providerインスタンス名 = StateProvider<状態のデータ型>((ref){
    // 初期値は状態のデータ型である必要がある
    return 初期値;
});

// 状態の読み取り
ref.watch(Providerインスタンス名)

// 状態の変更(例. インクリメント)
ref.read(Providerインスタンス名.notifier).state++
```

### Notifier, NotifierProvider:
StateProviderでできることは全てできる。
Notifierにはメソッドが定義でき、複雑な状態も扱いやすい。

```dart
class Notifierクラス名 extends Notifier<状態のデータ型> {
  @override
  build() {
    // 初期値
    // 状態のデータ型である必要がある
    return 初期値;
  }

  // stateを変更して状態を更新するメソッド
  void increment() {
    // stateがNotiferが扱う状態を表す
    state++;
  }
}

// 状態の読み取り
// 状態の読み取り
ref.watch(Providerインスタンス名)

// 状態の変更(例. インクリメント)
ref.read(Providerインスタンス名.notifier).state++
ref.read(Providerインスタンス名.notifier).increment()

```

### NotifierProviderの自動生成

ターミナルで以下をまず実行しておく。

```sh
flutter pub run build_runner watch
```

自動生成するための材料となるNotifierクラスを定義する。

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ファイル名.g.dartでpart宣言する
part 'ファイル名.g.dart';

@riverpod
class Notifierクラス名 extends _$Notifierクラス名{
    @override
    データ型 build(){
        return 初期値;
    }

    // メソッド定義
    void メソッド名(){
        // stateで管理している状態にアクセス
        // ex. state++
        // ex. state = [1,2,3,4,...]
        // ex. state = state * 2
    }
}

```


## サンプルアプリ:Simple Counter

Notifier、NotifierProviderを使ったデモ。

### StateProviderを使った例

StateProviderはシンプルな値を扱う際便利。

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 基本となるStateProvider
final counterProvider = StateProvider<int>((ref) => 0);

class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // providerの参照
    final counter = ref.watch(counterProvider);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          // provider取得した値を表示
          child: Text('$counter'),
          // providerのstateを更新
          onPressed: () => ref.read(counterProvider.notifier).state++,
        ),
      ),
    );
  }
}
```

しかしバリデーションや複雑なロジックを実装する際に不便。

### NotifierProviderを使った例

そこでNotiferを使うとこのようなケースに簡単に対応できる。
CounterWidget側は変更しなくてもOK。

```dart

// Notifierを使った例
class Counter extends Notifier<int> {
  @override
  build() {
    // 初期値
    // Notifier<データ型>のデータ型の値をreturnする
    return 0;
  }

  // stateを変更して状態を更新するメソッド
  void increment() {
    // stateがNotiferが扱う状態を表す
    state++;
  }
}

final counterProvider = NotifierProvider<Counter, int>(() {
  return Counter();
});

// 以下のように書いても同じ意味
// final counterProvider =
//     NotifierProvider<Counter, int>(Counter.new);

```

Notifierで定義したincrement()を使用する場合、次のように書く。

```dart
onPressed: () => ref.read(counterProvider.notifier).increment()
```

### NotifierProviderを自動生成する

上記のCounterの例を用いる。
もし自動生成で同じNotifierProviderを生成する場合は、
以下のように記述する。
この時 `flutter pub run build_runner watch`を実行しておく。

counter.dart:
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ファイル名.g.dartでpart宣言する
part 'counter.g.dart';

// @riverpodアノテーションをつける
@riverpod
// _$クラス名でextendsする
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }

  void increment() {
    // 状態を読み取る場合はstate
    state++;
  }
}
```
このコードを保存するとcounter.g.dartファイルが
counter.dartと同じディレクトリに生成される。

自動生成されたProviderを使用するには
`import counter.dart`をする。

## サンプルアプリ:AsyncValuePractice

AsyncNotifer、AsyncNotiferProviderを使用する前段として
AsyncValueの使い方を確認する練習アプリ。

### AsyncValueとは

riverpodで使用されるデータクラス。

- 非同期処理で扱うデータ用
- 現在の状態がわかる
- 現在の状態に応じた処理を記述しやすい

`AsyncValue`は`FutureProvider`や`StateNotifierProvider`などと合わせて使われる。

### サンプルアプリの説明

例えばポケモンに関する情報を取得できるPokeApiを使ってみる。
まずポケモンのデータを扱う`StateNotifier`クラスを作成する。

```dart
class PokemonNotifier extends StateNotifier<AsyncValue<Map>> {
  // 初期値はloading状態にしておく
  PokemonNotifier() : super(const AsyncValue.loading()) {
    // 初回参照時にfetch処理を開始
    fetchRandomPokemon();
  }

  Future<void> fetchRandomPokemon() async {
    final randomId = Random().nextInt(150);

    // ランダムなidのポケモンjson
    final url = Uri.https('pokeapi.co', 'api/v2/pokemon/$randomId');

    // 状態をローディングに変更
    state = const AsyncValue.loading();

    try {
      state = AsyncValue.data(jsonDecode(response.body));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
```

次に`PokemonNotifier`を配布する`StateNotifierProvider`を作成する。

```dart
final pokemonProvider =
    StateNotifierProvider<PokemonNotifier, AsyncValue<Map>>((ref) {
  return PokemonNotifier();
});
```

`PokemonNotifier`を参照するには次のようにする。

```dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generator_with_notifier_and_asyncnotifier/async_value_practice/fetch_pokemon.dart';

class JsonFetchPage extends ConsumerWidget {
  const JsonFetchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomPokemon = ref.watch(pokemonProvider);
    return Scaffold(
      body: Center(
        // .when()でdata, loading, errorの状態時の画面を定義できる
        child: randomPokemon.when(
            //  stateがAsyncValue.data()になった時
            data: (pokemon) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(
                          pokemon["sprites"]["other"]["official-artwork"]
                              ["front_default"],
                          fit: BoxFit.fill),
                    ),
                    Text(
                      pokemon["name"],
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
            // stateがAsyncValue.error()になった時
            error: (_, __) => const Text('error'),
            // stateがAsyncValue.loading()になった時
            loading: () => CircularProgressIndicator(
                  color: Colors.blue,
                )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('change pokemon'),
        onPressed: () {
          // StateNotifierで定義されたメソッドを呼び出す
          ref.read(pokemonProvider.notifier).fetchRandomPokemon();
        },
      ),
    );
  }
}
```

`FutureProvider`でも`AsyncValue`は配布できる。
ただし`StateNotifierProvider`のように扱うデータを直接計算処理（ref.read(...notifier)...のような処理）
ができないので、もしもし再読込処理が必要な場合は`StateNotifierProvider`を使う。

### AsyncValue.guard()

```dart
final response = await http.get(url);

try {
  state = AsyncValue.data(jsonDecode(response.body));
} catch (e, stack) {
  state = AsyncValue.error(e, stack);
}
```

を

```dart
state = await AsyncValue.guard(() async {
  final response = await http.get(url);
  return jsonDecode(response.body);
});
```

少し短く書ける。ただしエラー時にStateNotifier側で
何かしらの追加処理を行いたい場合は`AsyncValue.guard()`
ではない方法で書く必要がある。