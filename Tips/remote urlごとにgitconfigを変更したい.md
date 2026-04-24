## 結論
`includeIf:hasconfig`を使う
```gitconfig
[includeIf "hasconfig:remote.*.url:git@github.com/bob/**]
	path = identities/bob.config
```

なお、https://, sshどちらもある場合はどちらも書く必要がある。