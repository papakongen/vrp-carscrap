--██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗░██████╗░███████╗███╗░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██╔══██╗████╗░██║██╔════╝░██╔════╝████╗░██║
--██████╔╝███████║██████╔╝███████║█████═╝░██║░░██║██╔██╗██║██║░░██╗░█████╗░░██╔██╗██║
--██╔═══╝░██╔══██║██╔═══╝░██╔══██║██╔═██╗░██║░░██║██║╚████║██║░░╚██╗██╔══╝░░██║╚████║
--██║░░░░░██║░░██║██║░░░░░██║░░██║██║░╚██╗╚█████╔╝██║░╚███║╚██████╔╝███████╗██║░╚███║
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝╚═╝░░╚══╝

local searched = {3423423424}
local canSearch = true
local Car = {10106915, 322493792, -273279397, -915224107, 591265130, 1120812170, 929870599, 1120812170, -1748303324, 1434516869, 1069797899, -52638650, 1898296526, 2090224559, 1723816705, -105334880, -896997473}  
local searchTime = 14000


Citizen.CreateThread(function(time)
    while true do
        Citizen.Wait(0)
        if canSearch then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local carFound = false

            for i = 1, #Car do
                local car = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, Car[i], false, false, false)
                local dumpPos = GetEntityCoords(car)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
                local playerPed = PlayerPedId()


                if dist < 1.8 then
                    DrawText3Ds(dumpPos.x, dumpPos.y, dumpPos.z + 1.0, 'Tryk [~g~E~w~] for søge bilen igennem')
                    if IsControlJustReleased(0, 54) then
                        for i = 1, #searched do
                            if searched[i] == car then
                                carFound = true
                            end
                            if i == #searched and carFound then
                                exports['mythic_notify']:DoCustomHudText('error', "Denne bil har der alledere været en", 5000)
                            elseif i == #searched and not carFound then
                                exports['mythic_notify']:DoCustomHudText('success', "Du begyndte at gennem søge bilen", 5000)
                                   startSearching(searchTime, 'amb@prop_human_bum_bin@base', 'base', 'sbop:server:rewarditem')
                                TriggerServerEvent('vrp:startcarTimer', car)
                                table.insert(searched, car)
                                Citizen.Wait(1000)
                            --    ClearPedTasks(playerPed)
                           --     FreezeEntityPosition(playerPed, false)
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('vrp:removecar')
AddEventHandler('vrp:removecar', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

-- Functions

function startSearching(time, dict, anim, cb)
    local animDict = dict
    local animation = anim
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()


    canSearch = false

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
        TaskPlayAnim(ped, animDict, animation, 8.0, 8.0, time, 1, 1, 0, 0, 0)
    FreezeEntityPosition(playerPed, true)
    local ped = GetPlayerPed(-1)
	-------
	Din progressbar her
	------
 Citizen.Wait(5000)
    ClearPedTasks(ped)
    FreezeEntityPosition(playerPed, false)
    canSearch = true
    TriggerServerEvent("vrp:rewarditem")
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 460
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.3, 0.3)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 160)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0115, 0.02 + factor, 0.027, 28, 28, 28, 95)
end
