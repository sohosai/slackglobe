# slackglobe

Slack inter-team message proxy

## Usage

Write `config.json`:

```json
{
  "team1-label": {
    "channel": "global",
    "token": "token-token-token"
  },
  "team2-label": {
    "channel": "global",
    "token": "token-token-token"
  }
}
```

`label` may be named as you like.

Run `coffee index.coffee`.
