#docker-compose 

docker-composeファイルでmountする

[[docker-compose.ymlを別ファイルで上書きしたい_on_DevContainer]]参照して、`docker-compose.extend.yml`を作成する
```yaml
services:
  app:
    volumes:
      - ~/.gitconfig:/home/work/.gitconfig:ro,cached
```

