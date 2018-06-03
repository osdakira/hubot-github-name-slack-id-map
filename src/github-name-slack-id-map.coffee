# Description
#   Keep correspondence between github_name and slack_id
#
# Configuration:
#   HUBOT_SLACK_TOKEN
#   HUBOT_GITHUB_TO_SLACK_NAME_MAP_KEY
#
# Commands:
#   hubot github_to_slack
#   hubot github_to_slack add <githubName> as <slackName>
#   hubot github_to_slack remove <githubName>
#
# Author:
#   Akira Osada <osd.akira@gmail.com>

module.exports = (robot) ->
  key = process.env.HUBOT_GITHUB_TO_SLACK_NAME_MAP_KEY || "HUBOT_GITHUB_TO_SLACK_KEY"

  robot.respond /github_to_slack$/, (res) ->
    res.reply _getMapToStrng()

  robot.respond /github_to_slack add (\w+) as ([\w\.\'-,]+)$/i, (res) ->
    githubName = res.match[1]
    slackName = res.match[2]
    if _updateMap(githubName, slackName)
      res.reply _getMapToStrng()
    else
      res.reply "#{slackName} not found"

  robot.respond /github_to_slack remove (\w+)$/i, (res) ->
    githubName = res.match[1]
    _removeMap githubName
    res.reply _getMapToStrng()

  _fetchSlackIdByName = (slackName) ->
    getUserByNameFunc = robot.adapter.client.getUserByName
    getUserByNameFunc ||= robot.adapter.client.rtm.dataStore.getUserByName
    getUserByNameFunc(slackName)?.id

  _updateMap = (githubName, slackName) ->
    slackId = _fetchSlackIdByName slackName
    return unless slackId

    hash = _getMap()
    nameIdHash = {}
    nameIdHash[slackName] = slackId
    hash[githubName] = nameIdHash
    _setMap hash

  _removeMap = (githubName) ->
    hash = _getMap()
    delete hash[githubName]
    _setMap hash

  _getMap = ->
    robot.brain.get(key) ? {}

  _setMap = (hash) ->
    robot.brain.set key, hash

  _getMapToStrng = ->
    JSON.stringify _getMap()
