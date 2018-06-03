Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/github-name-slack-id-map.coffee')

describe 'github-name-slack-id-map', ->
  beforeEach ->
    @room = helper.createRoom()

    # stub adapter
    @room.robot.adapter.client =
      getUserByName: (slackName) -> { id: "slackID" }

  afterEach ->
    @room.destroy()

  it 'responds to github_to_slack add', ->
    command = "github_to_slack add githubName as slackName"
    @room.user.say('alice', "@hubot #{command}").then =>
      expect(@room.messages).to.eql [
        ["alice", "@hubot github_to_slack add githubName as slackName"],
        ["hubot", "@alice {\"githubName\":{\"slackName\":\"slackID\"}}"]
      ]

  it 'responds to github_to_slack remove', ->
    command = "github_to_slack remove githubName"
    @room.user.say('alice', "@hubot #{command}").then =>
      expect(@room.messages).to.eql [
        ['alice', "@hubot github_to_slack remove githubName"],
        ["hubot", "@alice {}"]
      ]
