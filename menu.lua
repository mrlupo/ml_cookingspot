--ml
local Keys = {
    ["R"] = 0xE30CD707,["Q"] = 0xDE794E3E,["O"] = 0xF1301666,["X"] = 0x8CC9CD42,
}



--food

Citizen.CreateThread(function()
    WarMenu.CreateMenu('campfire', "prepare food")
    WarMenu.SetSubTitle('campfire', 'prepare food')
    WarMenu.CreateSubMenu('cook', 'campfire', 'cook food')
	WarMenu.CreateSubMenu('cook1', 'campfire', 'Liquids')
  

    while true do

        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('campfire') then
            if WarMenu.MenuButton('Cook Food', 'cook') then
            end
			if WarMenu.MenuButton('Liquids', 'cook1') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('cook') then
            
            if WarMenu.Button('Cook Raw Meat') then
                       TriggerServerEvent("ml_cookfood:getmeat")
					   WarMenu.CloseMenu() 
			elseif WarMenu.Button('Cook Fish') then
                       TriggerServerEvent("ml_cookfood:getfish")
					   WarMenu.CloseMenu() 
 
			end
   
            WarMenu.Display()
		elseif WarMenu.IsMenuOpened('cook1') then
            
            if WarMenu.Button('Clean Dirty Water') then
                       TriggerServerEvent("ml_cookfood:getwater")
					   WarMenu.CloseMenu() 
 
			end
   
            WarMenu.Display()	
			
		elseif (Vdist(coords.x, coords.y, coords.z, -359.59, 742.14, 115.93) < 2.0) then -- val
           DrawText3D(-359.59, 742.14, 116.93, "~g~G~w~ To Cook Food")
            if whenKeyJustPressed(keys["G"]) then
            WarMenu.OpenMenu('campfire')
            end
        
		elseif (Vdist(coords.x, coords.y, coords.z, 453.28, 2213.15, 246.01) < 2.0) then -- native land
           DrawText3D(453.28, 2213.15, 247.01, "~g~G~w~ To Cook Food")
            if whenKeyJustPressed(keys["G"]) then
            WarMenu.OpenMenu('campfire')
            end
        end
        Citizen.Wait(0)
    end
end)



 local cookMeat = false
 local cleanWater = false
 local cookFish = false

RegisterNetEvent('ml_cookfood:cookmeat')
AddEventHandler('ml_cookfood:cookmeat', function()
	
    local playerPed = PlayerPedId()
	cookMeat = true  
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(27000, "Cooking meat...")
    Citizen.Wait(27000)
    ClearPedTasksImmediately(PlayerPedId())

end)

RegisterNetEvent('ml_cookfood:clean')
AddEventHandler('ml_cookfood:clean', function()

    local playerPed = PlayerPedId()
	cleanWater = true
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(27000, "Cleaning water...")
    Citizen.Wait(27000)
    ClearPedTasksImmediately(PlayerPedId())

end)

RegisterNetEvent('ml_cookfood:cookfish')
AddEventHandler('ml_cookfood:cookfish', function()
	
    local playerPed = PlayerPedId()
	local cookFish = true
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(27000, "Cooking fish...")
    Citizen.Wait(27000)
    ClearPedTasksImmediately(PlayerPedId())

end)


function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

function ShowPrompt(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end

local blips = {
	{ name = 'Cooking Spot', sprite = 1754365229, x=-359.59, y=742.14, z=115.93 },
	{ name = 'Cooking Spot', sprite = 1754365229, x=453.28, y=2213.15, z=246.01 },
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)