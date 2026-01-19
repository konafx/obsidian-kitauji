## Config
- `$XDG_CONFIG_HOME`を参照する

### settings.json
#### `ENABLE_TOOL_SEARCH`
[Claude Code の ENABLE_TOOL_SEARCH=1 の挙動を理解する 2026/01](https://zenn.dev/him0/articles/8b6c82e592e30b)

#### plansDirectory
> Claude Codeのsettings.json 内に `plansDirectory` を設定することで、Planドキュメントの保存先を指定できるようになりました。
> たとえば
>   "plansDirectory": "./plans"
> を設定すれば、プロジェクトルートのplans ディレクトリにPlanドキュメントが生成されます。
> (defaultは "~/.claude/plans")
> [午後1:16 · 2026年1月16日 - Oikon / X](https://x.com/oikon48/status/2012016162524315699)

### Prompts
#### `AskUserQuestion`
[Handle approvals and user input - Claude Docs](https://platform.claude.com/docs/en/agent-sdk/user-input)


## Coding
### sqlc
[sqlc-dev/sqlc: Generate type-safe code from SQL](https://github.com/sqlc-dev/sqlc)