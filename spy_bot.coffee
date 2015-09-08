Slack = require 'slack-client'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

formatting = require './formatting'

class SpyBot extends EventEmitter
  constructor: (token, @targetChannelName) ->
    super()
    @slack = new Slack(token, true, true)
    @slack.on 'message', @onMessage.bind(this)
    @slack.login()

  getTargetChannel: ->
    @slack.getChannelGroupOrDMByName(@targetChannelName)

  onMessage: (message) ->
    return if message.subtype?
    {ts, text} = message
    user = @slack.getUserByID(message.user)
    return if message.channel isnt @getTargetChannel().id

    @emit 'message',
      text: formatting.decode(@slack, text)
      icon_url: user.profile.image_48
      username: "#{@slack.team.name}/#{user.name}"
      team: @slack.team.id

  post: (message) ->
    return if message['team'] is @slack.team.id

    params = assign({
      channel: @getTargetChannel().id
      parse: 'full'
    }, message)

    delete params['team']

    @slack._apiCall 'chat.postMessage', params

module.exports = SpyBot
