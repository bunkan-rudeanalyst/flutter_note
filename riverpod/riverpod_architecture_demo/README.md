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

## Presentation

PresentationレイヤーのControllerについて説明する。
Controllerは以下の役割を持つ。

- ビジネスロジックの管理
- ウィジェットの状態管理
- Dataとのやりとり管理

PresentationはMVVMのViewに相当する。
基本的には`AsyncNotifier`を用いてControllerを構成する。

前述した通り、Presentationには以下の3要素がある。

- Widget
- State
- Controller

それぞれの関係は次のようになる。

- Widget
  - Stateの状態を観察してUIに反映
  - ユーザーが何かアクションをした場合、それをControllerに伝える
- State
  - Widgetから観察される
  - 更新はControllerのみ可能
- Controller
  - ユーザーからのアクションをWidgetから受け取る
  - Stateを変更する
  - ApplicationまたはDataのクラスを呼び出す

例えば簡単なTodoアプリを考える。
この時、各要素は次のようになる。

- Widget
  - TodoListPage
- State
  - AsyncNotifierを継承したTodoListPageControllerから取得する値
  - AsyncValue
- Controller
  - AsyncNotifierを継承
  - 初期値はDataのRepositoryから取得する（非同期）
  - get/update/deleteを画面構成に合わせて用意する
- Data
  - TodosRepository
  - TodoをList型で保持
  - Controllerのみとやりとりをする
  - テストを簡単にするには、Repositoryをabstractで抽象クラスとして定義する

TodoListPageではControllerをref.watch()で参照し、AsyncValueの状態に応じて.whenで表示を切り替える。
実際にTodoのリストを保持しているのはTodosRepository。Controllerには保持しない。

この構成のTodoアプリはサンプルとして実際に作成したので、実装を確認する場合はlibは以下のコードを参照。

## Application
## Domain
## Data

## 参照

https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/





