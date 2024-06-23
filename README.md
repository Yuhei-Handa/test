# project-template

AVILEN 開発用プロジェクトレポジトリのテンプレート

以下のようなコンセプトで構成されています

- アプリケーションコンテナ前提
  - 最初からコンテナ化します。アプリケーションデプロイはすべてコンテナ経由で行うようにすることで、管理を容易にし。保守性を高めることができます。
- モダンなパッケージ管理
  - poetry を使ってパッケージを管理します。
  - requirements.txt は表現力が弱く、ロックも難しいので使いません。
  - 必要であれば、requirements.txt を poetry から export することはできます。この場合、2 重管理にならないよう必ず gitignore します。
- オペレーション集約
  - リポジトリ内で行う手動操作はすべて `Makefile` に集約します。
  - Makefile は可読性が悪いので、あまり複雑な処理は書かないようにします、複雑な処理は別途 shellscript や python script を書き、それを実行するようにします。
- CI
  - github actions で CI/CD を行います。
  - 他の CI と比較して統合が楽だからです。
- クラウドインフラ
  - terraform で IaC します

# セットアップ

以下の手順に沿って開発環境を構築してください。

- Poetry
  - python パッケージマネージャ。依存関係を管理します。
    - requirements.txt は基本的に使いません。poetry に集約します。
- Docker
  - アプリケーションの動作環境は基本的にコンテナ化します。

## poetry のセットアップ

Python のパッケージマネージャとして[Poetry](https://python-poetry.org/)を利用します.  
インストール方法は see: https://python-poetry.org/docs/#installation

インストール後、仮想環境をグローバルでなくローカルディレクトリに作成する設定をします。

```bash
# この設定はデフォルトでtrueになってるはずだが、念の為。
poetry config virtualenvs.in-project true
```

poetry はパッケージマネージャであり、ライブラリの依存関係を管理します。
pyproject.toml に依存関係を記録し、poetry.lock がロックファイルです。
詳細は poetry の[公式ドキュメント](https://python-poetry.org/docs/)を参照。

### poetry 使い方チートシート

```sh
# pyproject.tomlに従って仮想環境が.venvに作成される。
# 冪等なので、久しぶりにリポジトリを触ったらとりあえずpoetry installしよう。
# うまくいかないときは.venvを一回削除してやり直す。
poetry install

# 依存パッケージの追加
poetry add ${ライブラリ名}

# 依存パッケージの更新
poetry update
```

## docker のセットアップ

`docker` 及び `docker compose` をセットアップします
see: https://docs.docker.com/engine/install/

### Docker 使い方チートシート

```bash
# コンテナをビルドする
docker compose build

# コンテナを起動する
docker-compose up
```

### VS Code で、docker コンテナ上で開発する方法

コンテナを起動して、vscode 左下の接続先で、`Reopen in Containor`を選択すれば、コンテナ上で開発可能

[参照](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-an-existing-folder-in-a-container)

# 開発時のルール

チームで開発するにあたって「開発のルール」を決めることはその後の開発を円滑に進めるためにも重要であり、チーム内でのコーディング規約の制定は最も重要なルールの 1 つです。コーディング規約をある程度明確に決めておくことによって、書き手による不要なコード差分が生じにくくなったりメンテナンス性が向上したりするだけでなく、コードレビューでスタイルの相違や違和感の指摘をする必要性も減るため、本来もっと重要なバグの発見やインターフェイスの議論などに使えた時間を些細な議論で大幅に消費してしまう状態に陥るのを防ぐこともできます。

[参照](https://tech.preferred.jp/ja/blog/pysen-is-the-new-sempai/)

## lint と format

linter と formatter は[pysen](https://github.com/pfnet/pysen)というツールを使います。

必要なコマンドは Makefile にまとめてあります。

```sh
# format
make format

# line
make lint
```

## CI/CD

github actions を使います。
github actions では以下のような処理を行いましょう。

- lint/format のチェック
- test
- deploy

## aws 関連のセットアップ

terraform で IaC します。

terraform/README.md を参照

# Tips

## 環境変数をディレクトリ毎に設定する

ディレクトリごとに環境変数を切り替えたい場合、[direnv](https://github.com/direnv/direnv)の利用を推奨します。
`.env` ファイルの存在を前提にするコードは非推奨です。なぜなら、環境変数はアプリケーションコンテナに外から inject するものだからです。

```bash
# .envrcに書き込んだスクリプトをそのディレクトリ以下に入ったときに実行してくれる。
echo 'export AWS_PROFILE=hogehoge' >> .envrc

# .envrcを更新するたびに許可が必要。セキュリティ的に。
direnv allow .
```

## Git の使い方

- [ガイド](https://avilen.esa.io/posts/10)
- [tips](https://avilen.esa.io/posts/273)

## x-window の設定方法

docker コンテナから cv2.imshow などを使う場合
ホスト上で下記のコマンドを実行

```sh
export DISPLAY=:0.0 && xhost +
# エラーが出たら1.0に変更して実行
export DISPLAY=:1.0 && xhost +
```
