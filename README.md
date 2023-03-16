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

orangeディレクトリに移動して次を実行。

```
flutter run
```