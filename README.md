# aiit-student-profile

## How to launch

http://localhost:3000/

```zsh
$ docker-compose up
```

## Build for development

はじめて環境を構築するときのみ、必要な手順です。

Build the container(for Mac M1):

```zsh
$ docker-compose -f docker-compose.m1.yml build
```

Install webpacker:

```zsh
$ docker-compose run web rails webpacker:install
```

Create database:

```zsh
$ docker-compose run web rake db:create
```

## References

- [Production](https://aiit-student-profile.herokuapp.com/)
- [Heroku dashboard](https://dashboard.heroku.com/apps/aiit-student-profile)
- [Quickstart: Compose and Rails](https://docs.docker.com/samples/rails/)