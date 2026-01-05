wip

## Goal
- リモートマシンで開発
- WezTermから launcher経由で Tailscale ssh 接続
- リモートマシン上でlocalhostサーバ起動
- Tailscale Serveを使って tailnet 内に Web公開
- 別端末のブラウザからアクセスできる

## 全体構成
```
[別端末]  
Browser  
|  
| https://${remote}.tailXXXX.ts.net  
|  
[Tailscale Serve]  
|  
| [http://localhost:4966](http://localhost:4966)  
|  
[liru]  
difit / dev server
```

## 前提条件（共通）

- 同一 tailnet（同じ Tailscale アカウント）
- 管理画面で **MagicDNS 有効**
- liru / 別端末 両方で Tailscale 起動中

## リモートマシンの設定

### 1. Tailscale を起動
```bash
tailscale up
```
確認
```bash
tailscale status
```
### 2. WezTerm で Tailscale SSH 用 launcher を設定
`~/.config/wezterm/local.lua`
```lua
config.ssh_domains = {
  {
    name = "remote",
    remote_address = "remote.tailXXXX.ts.net",
    username = "noize",
  },
}
```

- WezTerm -> NewTab -> SSH -> liru
- 通常のsshと同じ感覚で使える
### 3. リモートマシンでサーバ起動 (localhost)
例：
```bash
difit
```
- listen: localhost:4966
- この時点では外部から見えない
### 4. Tailscale Serve で localhost を公開

```bash
tailscale serve http://localhost:4966
```
期待される出力例：
```bash
https://remote.tailXXXX.ts.net
  / -> http://localhost:4966
```

※serveは433/HTTPS側に集約される
※`:4966`を外部から指定する必要がない

## 別端末の設定
### 1. Tailscaleを起動し、DNSを受け入れる
Windows (PowerShell)：
```powershell
tailscale up --accept-dns --accept-routes=false --shields-up --unattended
```
### 2. MagicDNSが有効か確認
```powershell
ping remote.tailXXXXX.ts.net
```
失敗する場合：
- `accept-dns` が無効
- MagicDNS が管理画面で OFF
### 3. ブラウザでアクセス
✅ 正解：
`https://liru.tailXXXX.ts.net`
❌ 間違い：
`http://liru.tailXXXX.ts.net:4966`

## よくあるハマりポイント
### localhost はそのままでは見えない
- `127.0.0.1` はそのマシン限定
- → Tailscale Serve か 0.0.0.0 bind が必要
### serve は HTTPS only になることがある
- `serve status` を必ず確認
- http/https を間違えない  
### DNS が引けない
- `ping *.ts.net` が通らない場合は `accept-dns`