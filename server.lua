data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)




-- cookfood

RegisterServerEvent('ml_cookfood:getmeat')
AddEventHandler("ml_cookfood:getmeat", function(name, weapon)
    local _source = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local count = data.checkItem(_source, "rawmeat")
		if count >= 1 then
		
			data.delItem(_source,"rawmeat", 1)
			
          TriggerClientEvent('ml_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"cookedmeat", 1)
                TriggerClientEvent("redemrp_notification:start", source, "Meat was cooked", 2, "success")
        else
            TriggerClientEvent("redemrp_notification:start", _source, 'You need: 1 Raw Meat', 3)
        end
    end)
end)

RegisterServerEvent('ml_cookfood:getfish')
AddEventHandler("ml_cookfood:getfish", function(name, weapon)
    local _source = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local count = data.checkItem(_source, "fish")
		if count >= 1 then
		
			data.delItem(_source,"fish", 1)
			
          TriggerClientEvent('ml_cookfood:cookfish', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"cookedfish", 1)
                TriggerClientEvent("redemrp_notification:start", source, "Fish was cooked", 2, "success")
        else
            TriggerClientEvent("redemrp_notification:start", _source, 'You need: 1 fish', 3)
        end
    end)
end)

RegisterServerEvent('ml_cookfood:getwater')
AddEventHandler("ml_cookfood:getwater", function(name, weapon)
    local _source = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local count = data.checkItem(_source, "dirtywater")
		if count >= 1 then
		
			data.delItem(_source,"dirtywater", 1)
			
          TriggerClientEvent('ml_cookfood:clean', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"water", 1)
                TriggerClientEvent("redemrp_notification:start", source, "Water was cleaned", 2, "success")
        else
            TriggerClientEvent("redemrp_notification:start", _source, 'You need: 1 Dirty water', 3)
        end
    end)
end)


RegisterServerEvent("RegisterUsableItem:emptybottle")
AddEventHandler("RegisterUsableItem:emptybottle", function(source)
    TriggerClientEvent('ml_camping:Getwater', source)
end)


RegisterNetEvent("collect")
AddEventHandler("collect", function()

    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
            data.addItem(source,"dirtywater", 1)
			
    end)
    TriggerClientEvent("redemrp_notification:start",source, "You collected dirty water!", 2)
end)
