#git

ワークスペースの`.gitignore`や`~/.gitignore`を変更せずに、ワークスペース内で`gitignore`したいとき

## 結論
`.git/info/exclude`を使う

## 例
[mise](https://github.com/jdx/mise)でnodejsを管理しているが、ワークスペース（＝プロジェクト）標準ではない。
標準化せずに、個人で使う分に収めたいが、`.mise.toml`がdiffに表れて面倒な場合に使える

`.gitignore`で`.mise.toml`を除外していないためuntracked fileになる
```
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .mise.toml

nothing added to commit but untracked files present (use "git add" to track)
```

`.git/info/exclude`に`.mise.toml`を追加する
```gitignore
# git ls-files --others --exclude-from=.git/info/exclude
# Lines that start with '#' are comments.
# For a project mostly in C, the following would be a good set of
# exclude patterns (uncomment them if you want to use them):
# *.[oa]
# *~
.mise.toml
```

プロジェクト、ローカル全体に影響を及ぼすことなく、ワークスペースフォルダ内の設定のみでignoreされる
```
$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```



