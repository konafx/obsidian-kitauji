#docker-compose #devcontainer

docker-composeファイルを複数指定し、設定の上書きを行う

`.devcontainer/devcontainer.json`を編集し、`docker-compose.extend.yml`をdocker-composeファイルとして追加する
```diff
@@ -3,7 +3,7 @@
 // Update the VARIANT arg in docker-compose.yml to pick a Node.js version
 {
   "name": "Test",
-  "dockerComposeFile": "docker-compose.yml",
+  "dockerComposeFile": ["docker-compose.yml", "docker-compose.extend.yml"],
   "service": "app",
   "workspaceFolder": "/workspace",
```

`.devcontainer/docker-compose.extend.yml`を作成する
（例：ポート番号を変更する）
```yaml
services:
  web:
    ports:
      - "18000:8000"
```

rebuildかrestartする

---
## Ref
[Create a Dev Container](https://code.visualstudio.com/docs/devcontainers/create-dev-container)