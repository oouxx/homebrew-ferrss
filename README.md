# homebrew-ferrss

Homebrew tap for [Ferrss](https://github.com/oouxx/Ferrss) — an AI-driven CLI tool that turns websites into command-line interfaces.

## Install

```bash
brew tap oouxx/ferrss
brew install ferrss
```

## Run the REST/RSS server as a background service

The formula ships a `service` definition, so `brew services` manages it for you:

```bash
brew services start ferrss     # start now + restart at login
brew services list             # check status
brew services stop ferrss
brew services restart ferrss
```

By default the service listens on `0.0.0.0:8080`:

- JSON API: `http://localhost:8080/api/run/<site>/<command>?arg=value`
- RSS feeds: `http://localhost:8080/rss/<site>/<command>`
- Health:    `http://localhost:8080/health`
- Index:     `http://localhost:8080/`

Logs: `$(brew --prefix)/var/log/ferrss-serve.log`

To change the bind address or port, edit the `service do ... end` block in
`Formula/ferrss.rb` and run `brew services restart ferrss`.

## Upgrade

```bash
brew update
brew upgrade ferrss
```

## Notes

- macOS only (Apple Silicon and Intel). The Linux release binaries are not
  wired into this formula yet.
- The CLI used to be called `autocli`; `~/.autocli` and `AUTOCLI_*` are still
  read as fallbacks, and the first run migrates `~/.autocli` to `~/.ferrss`.
