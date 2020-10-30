webhook = ""
local DISCORD_NAME = "Report Bot" 
local DISCORD_IMAGE = "https://th.bing.com/th/id/OIP.GvZHe1SbMqrSCXl18X_lCwHaIr?pid=Api&rs=1"

PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({avatar_url = DISCORD_IMAGE, username = DISCORD_NAME, content = "Report Bot is **ONLINE**", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

RegisterServerEvent('bugs:report')
AddEventHandler('bugs:report',function(name, message)
    color = 16711480
    discordWebhook("" .. " **Νέο Bug Reported:** ", message , color, "Έγινε αναφορά από τον: " .. name)
end)

RegisterServerEvent('player:results')
AddEventHandler('player:results', function(name1, name2, reason)
    color = 16711480
    discordWebhook("O " .. name1 .. " έγινε αναφορά! ", reason , color, "Έγινε αναφορά από τον: " .. name2)
end)

function discordWebhook(title, msg, color, text)
    local connect = {
          {
              ["color"] = color,
              ["title"] = title,
              ["description"] = msg,
              ["footer"] = {
              ["text"] = text,
              },
          }
      }
      PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = connect, avatar_url = DISCORD_IMAGE, username = DISCORD_NAME}), { ['Content-Type'] = 'application/json' })
  end
