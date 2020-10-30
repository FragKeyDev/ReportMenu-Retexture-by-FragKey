anonymous = 0
position = 1420

print("^2Το Report Bot είναι ONLINE")

local mainMenu = RageUI.CreateMenu("", "RETEXTURED BY FRAGKEY", position, nil, "banner", "shopui_title_gunclub")
local subMenu =  RageUI.CreateSubMenu(mainMenu, "", "MADE BY FRAGKEY", position, nil, "banner", "shopui_title_gunclub")
local subMenu2 =  RageUI.CreateSubMenu(mainMenu, "", "MADE BY FRAGKEY", position, nil, "banner", "shopui_title_gunclub")
local subMenu3 =  RageUI.CreateSubMenu(mainMenu, "", "MADE BY FRAGKEY", position, nil, "banner", "shopui_title_gunclub")

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
end
mainMenu.EnableMouse = false
mainMenu.onIndexChange = function(Index)
end

Keys.Register('I', 'I', 'Open RageUI Showcase menu default.', function()
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
end)

local index = {
    checkbox = false,
    list = 2,
    heritage = 0.5,
    slider = 50,
    sliderprogress = 50,
    grid = {
        default = { x = 0.5, y = 0.5 },
        horizontal = { x = 0.5 },
        vertical = { y = 0.5 },
    },
    percentage = 0.5,
    color = {
        primary = { 1, 5 },
        secondary = { 1, 5 }
    },
}

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1.0)

        RageUI.IsVisible(mainMenu, function()

            RageUI.Button('~r~REPORT PLAYERS', '~r~Report Players', { RightLabel = "→→→" }, true, {
                onHovered = function()
                end,
                onSelected = function()

                local nameResults = KeyboardInput("Enter Players Name:", "", 20)
                local reasonResults = KeyboardInput("Enter Reason: ", "", 200)

                if anonymous == 1 then
                    playerName = 'Anonymous'
                else
                    playerName = GetPlayerName(PlayerId())
                end

                if nameResults == nil or nameResults == "" then
                    TriggerEvent('chatMessage', "Bot", {255, 0, 0}, " Δεν έβαλες όνομα!")
                else
                    TriggerServerEvent('player:results', nameResults, playerName, reasonResults)
                    TriggerEvent('chatMessage', "Bot", {0, 255, 0}, "Έκανες report τον ".. nameResults .. " για τον λόγο " .. reasonResults)
                    end
                end,
            });

            RageUI.Button('~r~REPORT BUG', '~r~Report Bugs', { RightLabel = "→→→" }, true, {
                onHovered = function()
                end,
                onSelected = function()
                    local bugresults = KeyboardInput("REPORT BUG:", "", 200)

                    if anonymous == 1 then
                        playerName = 'Anonymous'
                    else
                        playerName = GetPlayerName(PlayerId())
                    end

                    if bugresults == "Describe the Bug" then
                        TriggerEvent('chatMessage', "Bot", {255, 0, 0}, " Άδειο Μήνυμα")
                    elseif bugresults == nil or bugresults == "" then
                        TriggerEvent('chatMessage', "Bot", {255, 0, 0}, " Άδειο Μήνυμα")
                    else
                        TriggerServerEvent('bugs:report', playerName, bugresults)
                        TriggerEvent('chatMessage', "Bot", {0, 255, 0}, "Έκανες report το bug στο DEV Team.")
                    end
                end,
            });
        end)


            -- SETTNINGS
            RageUI.IsVisible(subMenu3, function()

                RageUI.Checkbox('Anonymous', 'This will make you anonymous in when you report a bug/player.', index.checkbox, {}, {
                    onChecked = function()
                        anonymous = 1
                    end,
                    onUnChecked = function()
                        anonymous = 0
                    end,
                    onSelected = function(Index)
                        index.checkbox = Index
                    end
                })

            end, function() end)
    end

end)

mainMenu:DisplayGlare(true)
subMenu:DisplayGlare(true)
subMenu2:DisplayGlare(true)
subMenu3:DisplayGlare(true)

mainMenu:DisplayPageCounter(true)
subMenu:DisplayPageCounter(true)
subMenu2:DisplayPageCounter(true)
subMenu3:DisplayPageCounter(true)

-- Functions below

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true 
    
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500)
		blockinput = false 
		return nil 
	end
end


AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        print('^1Το Report Bot είναι OFFLINE')
    end
end)