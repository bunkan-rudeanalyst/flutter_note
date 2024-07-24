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



## generatorとは

riverpod_generatorのこと。

https://pub.dev/packages/riverpod_generator

Providerの生成を自動で行ってくれる。
実行にはbuild_runnerを利用する。

generatorツールの起動は以下のコマンドを実行する。

```sh
flutter pub run build_runner watch
```

- Notifierとは
- AsyncNotifierとは