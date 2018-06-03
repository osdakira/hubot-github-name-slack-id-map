# hubot-github-name-slack-id-map

Keep correspondence between github_name and slack_id
Support tool for converting mentions with other scripts

See [`src/github-name-slack-id-map.coffee`](src/github-name-slack-id-map.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-github-name-slack-id-map --save`

Then add **hubot-github-name-slack-id-map** to your `external-scripts.json`:

```json
[
  "hubot-github-name-slack-id-map"
]
```

Set `HUBOT_GITHUB_TO_SLACK_NAME_MAP_KEY` environment variable.

## Sample Interaction

```
user1>> hubot github_to_slack add githubName as slackName
hubot>> {"githubName":{"slackName":"slackID"}}
```

## NPM Module

https://www.npmjs.com/package/hubot-github-name-slack-id-map
