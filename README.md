# aiit-student-profile

## How to launch

http://localhost:3000/

```zsh
$ docker-compose up
```

## Build for development

はじめて環境を構築するときのみ、必要な手順です。

Set environment:
```zsh
$ cp .env.example .env
```

使用しているマシンが arm(M1 Mac など) の場合、 env の値を修正してください。

Install webpacker:

```zsh
$ docker-compose run web rails webpacker:install
```

Create database:

```zsh
$ docker-compose run web rake db:create
```

### Optional
ローカルで自分でビルドしたい場合は `docker-compose.yml` を以下のように編集し、

```diff
-     image: chiroruxx/aiit_student_profule:${CPU}-latest
+     build: .
```

以下のコマンドを実行することでビルドできます。

```shell
docker-compose build --build-arg credential_key=your_dev_credential_key
```

`your_dev_credential_key` のところには、自身のローカルのキーファイルの内容を入れてください。

## References

- [Production](https://aiit-student-profile.herokuapp.com/)
- [Heroku dashboard](https://dashboard.heroku.com/apps/aiit-student-profile)
- [Quickstart: Compose and Rails](https://docs.docker.com/samples/rails/)