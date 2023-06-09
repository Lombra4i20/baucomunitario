local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core 
end)

progressbar = exports.vorp_progressbar:initiate()


Citizen.CreateThread(function()
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
    local firstprompt = PromptGroup:RegisterPrompt("Acessar cofre", 0xCEFD9220, 1, 1, true, 'hold', {timedeventhash = "SHORT_TIMED_EVENT_MP"}) --Register your first prompt

    --Define the areas to check
    local areas = {
        vector3(-291.67, 785.1, 119.47),
        vector3(2635.6, -1271.51, 52.48),
        vector3(-790.83, -1304.68, 43.84),
        vector3(-1407.31, -2297.29, 43.62),
        vector3(2922.89, 1353.37, 45.06),
		vector3(-1316.34, 2436.4, 310.94)
    }

    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId() --Get player ped
        local playerCoords = GetEntityCoords(playerPed) --Get player coordinates

        --Check if player is in any of the defined areas
        local isPlayerInArea = false
        for i=1,#areas do
            local distance = #(areas[i] - playerCoords)
            if distance <= 2 then --Assuming a radius of 50 units for each area
				
                isPlayerInArea = true
                break
            end
        end

        if isPlayerInArea then
			
            PromptGroup:ShowGroup("AREA DE DOAÇÕES")--Show prompt if player is in area
			if firstprompt:HasCompleted() then
			
			 progressbar.start("Acessando cofre", 2000, function ()
				end, 'linear')
				Citizen.Wait(2000)
				TriggerServerEvent('bauComunitario', args)				
			end		 
        else
        end
    end
end)


  
  RegisterCommand("clientnotify", function(args, rawCommand) --  COMMAND
    TriggerEvent('vorp:NotifyLeft', "first text1", "second text", "generic_textures", "tick", 4000)
    Wait(4000)
    TriggerEvent('vorp:Tip', "your text2", 4000)
    Wait(4000)
    TriggerEvent('vorp:NotifyTop', "your text3", "TOWN_ARMADILLO", 4000)
    Wait(4000)
    TriggerEvent('vorp:TipRight', "your text4", 4000)
    Wait(4000)
    TriggerEvent('vorp:TipBottom', "your text5", 4000)
    Wait(4000)
    TriggerEvent('vorp:ShowTopNotification', "your text6", "your text", 4000)
    Wait(4000)
    TriggerEvent('vorp:ShowAdvancedRightNotification', "your text7", "generic_textures", "tick", "COLOR_PURE_WHITE", 4000)
    Wait(4000)
    TriggerEvent('vorp:ShowBasicTopNotification', "your text8", 4000)
    Wait(4000)
    TriggerEvent('vorp:ShowSimpleCenterText', "your text9", 4000)
    Wait(4000)
    TriggerEvent('vorp:ShowBottomRight', "your text10", 4000)
    Wait(4000)
    TriggerEvent('vorp:deadplayerNotifY', "tittle11", "Ledger_Sounds", "INFO_HIDE", 4000)
    Wait(4000)
    TriggerEvent('vorp:updatemissioNotify', "tittleid", "tittle12", "message", 4000)
    Wait(4000)
    TriggerEvent('vorp:warningNotify', "tittl13e", "message", "Ledger_Sounds", "INFO_HIDE", 4000)
end)