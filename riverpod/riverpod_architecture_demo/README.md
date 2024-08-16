# riverpod_architecture_demo

Riverpodを用いたアーキテクチャの一例を解説。

## 概要

アプリの規模が小さければアーキテクチャを用意する必要がないかもしれないが、
ある程度の規模になった場合、アプリの作りに一定のルールが無いと保守が大変になる。
複数人で開発を行う場合はなおさら一定のルールがあると開発が楽になる。

そこでFlutterのパッケージ「Riverpod」を用いて、以下の特徴を持つアーキテクチャを構成する。

- UI、ロジック、データアクセスを分離
- データのフェッチをキャッシュが簡単
- UIの状態を予測可能
- テストが簡単

レイヤーは次の4つ。

1. Presentation
   - Widgets
   - States
   - Controllers
2. Application
   - Services
3. Domain
   - Models 
4. Data
   - Repositories
   - DTOs
   - Data Sources

### 各レイヤーの簡単な説明

**Presentation**

- アプリケーションのデータを画面に表示
- ユーザーとアプリとのインタラクションを表示

構成要素は次の2つ

- Widgets: 画面に実際に表示される要素
- Controllers: 非同期データの操作とウィジェットの状態管理。一般的には`AsyncNotifier`を用いる

https://codewithandrea.com/articles/flutter-presentation-layer/

**Application**

ControllersとRepositoriesの間を取り持つ、ロジックを含んだレイヤー

ControllersにRepositoriesへのアクセスロジックを実装してしまうと、関心の分離が適切に行えなくなる。

https://ja.wikipedia.org/wiki/%E9%96%A2%E5%BF%83%E3%81%AE%E5%88%86%E9%9B%A2

https://codewithandrea.com/articles/flutter-app-architecture-application-layer/


**Domain**

- アプリ内で使用するデータモデルを定義

DomainレイヤーではModelを定義する。Modelは次の要件を満たす

- 常にイミュータブル（変更不可）
- シリアル化するメソッドを持つ（fromJson、toJsonなど）
- モデルインスタンス同士を比較するメソッド、オペレーターを持つ

https://codewithandrea.com/articles/flutter-app-architecture-domain-model/

この要件を満たすために、`Equatable`や`Freezed`などを用いると良い。

https://pub.dev/packages/equatable

https://pub.dev/packages/freezed

**Data**

アプリ内で使用するデータを管理するレイヤー。次の3つの要素から成る

- Repositories: アプリ内から外部へのデータへアクセスするための、アプリ内エンドポイント
- DTOs: Data SourcesからRepositoriesに転送されるデータ。
- Data Sources: 外部のAPI

https://codewithandrea.com/articles/flutter-repository-pattern/


## 参照

https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/





