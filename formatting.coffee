module.exports =
  decode: (client, text) ->
    text.replace /<(.*?)>/g, (_, seq) ->
      suffix = seq.substring(1)

      # Channel Reference
      if seq.indexOf('#C') is 0
        return '#' + client.getChannelById(suffix).name

      # User Mention
      if seq.indexOf('@U') is 0
        return '@' + client.getUserByID(suffix).name

      # Command
      if seq.indexOf('!') is 0
        return switch suffix
          when 'everyone', 'channel', 'group' then '@' + suffix
          else "<#{suffix}>"

      # URL
      return seq
