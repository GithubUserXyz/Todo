# Todo

## 概要

Flutter(クライアント)とPython(サーバー)でつくったTodoアプリ。

![out](https://github.com/GithubUserXyz/Todo/assets/124037274/12d19f58-9715-4a16-81a6-23981a086b8e)


# 依存関係のインストール

```
pip install -r requirements.txt
```

# データベース作成

```
flask --app prog/todo shell
```

シェルが始まったら、次のコマンドでsqlite3のデータベースを作成。

```
db.create_all()
```

シェルから抜けるには次のコマンド。

```
exit()
```

# 実行

## サーバー

```
flask --app prog/todo run
```

127.0.0.1:5000でサーバー起動

## クライアント

grapeディレクトリに移動して次を実行。

```
flutter run
```

実行中にvを入力するとDevToolsというウェブブラウザを使った
デバッグツールが表示される。logはloggingタブから確認できる。

Error: Not found: 'package:http/http.dart'
のエラーがでた場合は以下を実行。

```
flutter packages get
```

# 動作環境

- Fedora 38上でPython3.11.3にてサーバー側の動作を確認している。