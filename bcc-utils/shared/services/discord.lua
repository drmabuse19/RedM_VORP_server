DiscordAPI = {}
local _internalSendMessage = function (webhookurl, webhookname, webhookavatar, name, description, embeds)
    if embeds == nil then
        embeds = {{
            color = 11342935,
            title = name,
            description = description
        }}
    end

    local payload = {
        username = webhookname,
        avatar_url = webhookavatar,
        type = 'rich',
        embeds = embeds
    }

    PerformHttpRequest(webhookurl, function(err, text, headers)end, 'POST', json.encode(payload), {
        ['Content-Type'] = 'application/json'
    })
end

-- Straight forward call
DiscordAPI.sendMessage = _internalSendMessage


-- Object/Class based call, allows for an "instance" that you can continue to sendmessages with.
DiscordAPI.setup = function (webhookurl, webhookname, webhookavatar)
    local discord_data = {}

    discord_data.webhookname = webhookname
    discord_data.webhookavatar = webhookavatar
    discord_data.webhookurl = webhookurl

    function discord_data:sendMessage(name, description, embeds)
        _internalSendMessage(self.webhookurl, self.webhookname, self.webhookavatar, name, description, embeds)
    end

    return discord_data
end