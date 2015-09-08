SpyBot = require './spy_bot'

config = require './config'

broadcast = (message) ->
  for bot in bots
    bot.post message

bots = for _, value of config
  bot = new SpyBot(value.token, value.channel)
  bot.on('message', broadcast)
  bot
