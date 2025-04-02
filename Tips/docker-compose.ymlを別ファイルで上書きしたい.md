#docker-compose 

[Compose 設定をファイルとプロジェクト間で共有 — Docker-docs-ja 24.0 ドキュメント](https://docs.docker.jp/compose/extends.html)

> １つは `docker-compose.yml` で、もう１つはオプションで `docker-compose.override.yml` ファイルです。

`docker-compose.override.yml`に上書きしたい設定を書けば、（docker composeであれば）勝手に上書きしてもらえる。

devcontainerの場合は別
[[docker-compose.ymlを別ファイルで上書きしたい_on_DevContainer]]