--██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗░██████╗░███████╗███╗░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██╔══██╗████╗░██║██╔════╝░██╔════╝████╗░██║
--██████╔╝███████║██████╔╝███████║█████═╝░██║░░██║██╔██╗██║██║░░██╗░█████╗░░██╔██╗██║
--██╔═══╝░██╔══██║██╔═══╝░██╔══██║██╔═██╗░██║░░██║██║╚████║██║░░╚██╗██╔══╝░░██║╚████║
--██║░░░░░██║░░██║██║░░░░░██║░░██║██║░╚██╗╚█████╔╝██║░╚███║╚██████╔╝███████╗██║░╚███║
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝╚═╝░░╚══╝

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp-carscrap")



RegisterServerEvent('vrp:startcarTimer')
AddEventHandler('vrp:startcarTimer', function(car)
    startTimer(source, car)
end)

RegisterServerEvent('vrp:rewarditem')
AddEventHandler('vrp:rewarditem', function(listKey)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
  
    local noroc = math.random(0, 150)
    local suma = math.random(1, 3)
  
    if noroc >= 0 and noroc <= 25 then
        vRP.giveInventoryItem({user_id, "hampblad", suma})
    elseif noroc >=25 and noroc <=50 then
        vRP.giveInventoryItem({user_id, "jern", suma})
    elseif noroc >=50 and noroc <=75 then
        vRP.giveInventoryItem({user_id, "pose", suma})
    elseif noroc >=75 and noroc <=100 then
        vRP.giveInventoryItem({user_id, "lsd", suma})
    elseif noroc >=100 and noroc <=125 then
        vRP.giveInventoryItem({user_id, "kokain", suma})
    elseif noroc >=125 and noroc <=150 then
        vRP.giveInventoryItem({user_id, "strips", suma})
      end
  end)

function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('vrp:removecar', id, object)
        end
    end
end