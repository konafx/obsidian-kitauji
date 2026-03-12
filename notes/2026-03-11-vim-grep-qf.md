###  `:grep` + 外部grepツール

`vimgrep` はVimScript内部で処理するため遅いです。大量ファイルには外部grepを使うべきです。

```vim
" grepprg を ripgrep に設定（init.lua等で）
vim.o.grepprg = "rg --vimgrep --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"

" 使い方（結果は同じく quickfix に入る）
:grep UserId sample/dbsync_to_sis/
```

これで **数十〜数百倍高速** になり、`.gitignore` も自動で尊重されます。

### filter のラムダ式（Neovim推奨）

古い文字列式より Lua や lambda の方が読みやすいです。

```vim
" Vim9 / Neovim の lambda 式
:call setqflist(filter(getqflist(), {_, v -> bufname(v.bufnr) !~# 'test'}))
```

Lua でも書けます:

```lua
local qf = vim.fn.getqflist()
qf = vim.tbl_filter(function(item)
  return not vim.fn.bufname(item.bufnr):match("test")
end, qf)
vim.fn.setqflist(qf)
```

### 3. Telescope との連携

既に Telescope を使っているなら、`live_grep` → quickfix 送りが便利です。

```
<leader>fg  → live_grep で検索
Ctrl-q      → 選択結果を quickfix に送る（デフォルトキーマップ）
```

これで grep を使う場面がかなり減ります。

### 4. `cfdo` より `cdo` の使い分け

| コマンド    | 動作                                |
| ------- | --------------------------------- |
| `:cdo`  | quickfix の **各エントリ** に対して実行       |
| `:cfdo` | quickfix の **各ファイル** に対して実行（重複除去） |

一括置換なら:

```vim
:cdo s/OldName/NewName/g | update
```

ファイル単位の操作なら:

```vim
:cfdo tabedit %
```

### 5. `colder` / `cnewer` で履歴を辿れる

quickfix はスタックになっており、過去の検索結果に戻れます。

```vim
:colder    " 前の quickfix list に戻る
:cnewer    " 次の quickfix list に進む
```

`setqflist` でフィルタする前に覚えておくと、元の結果にいつでも戻れます。

### 6. quickfix をタブでなくバッファで開く

タブを大量に開くとかえって操作しづらくなります。代替案:

```vim
" arglist に入れてバッファとして操作
:cdo argadd %
:argdo edit
```

または quickfix ウィンドウ内で直接 `Enter` で移動する方が実用的です。

---

## まとめた推奨ワークフロー

```vim
" 1. ripgrep で高速検索 → quickfix
:grep UserId sample/dbsync_to_sis/
:copen

" 2. 不要ファイルを除外
:call setqflist(filter(getqflist(), {_, v -> bufname(v.bufnr) !~# 'test'}))

" 3. 一括置換する場合
:cdo s/UserId/AccountId/g | update

" 4. フィルタ前に戻したければ
:colder
```

最大のポイントは **`vimgrep` → `:grep` + `rg`** への置き換えです。速度差が大きく、実務では `rg` 一択と言ってよいです。