local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX                           = nil
local GUI      = {}
local PlayerData                = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time                      = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil

function getItemyWeight(item)
  local weight = 0
  local itemWeight = 0

  if item ~= nil then
	   itemWeight = Config.DefaultWeight
	   if arrayWeight[item] ~= nil then
	        itemWeight = arrayWeight[item]
	   end
	end
  return itemWeight
end


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  	PlayerData = xPlayer
    TriggerServerEvent("esx_truck_inventory:getOwnedVehicule")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_truck_inventory:setOwnedVehicule')
AddEventHandler('esx_truck_inventory:setOwnedVehicule', function(vehicle)
    vehiclePlate = vehicle
end)

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function VehicleMaxSpeed(vehicle,weight,maxweight)
  local percent = (weight/maxweight)*100
  local hashk= GetEntityModel(vehicle)
  if percent > 80  then
    SetEntityMaxSpeed(vehFront,GetVehicleModelMaxSpeed(hashk)/1.4)
  elseif percent > 50 then
    SetEntityMaxSpeed(vehFront,GetVehicleModelMaxSpeed(hashk)/1.2)
  else
    SetEntityMaxSpeed(vehFront,GetVehicleModelMaxSpeed(hashk))
  end
end

function openmenuvehicle()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local vehicle   = VehicleInFront()
	globalplate  = GetVehicleNumberPlateText(vehicle)
	if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
		ESX.TriggerServerCallback('esx_truck:checkvehicle',function(valid)
			if (not valid) then
				--ESX.ShowNotification('Vehicle ~r~Locked')
				--CloseToVehicle = true
				--TriggerServerEvent('esx_truck_inventory:AddVehicleList', globalplate)
				--print(valid)
				local vehFront = VehicleInFront()
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
				local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
			  if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
					lastVehicle = vehFront
					local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
					local locked = GetVehicleDoorLockStatus(closecar)
					local class = GetVehicleClass(vehFront)
					  ESX.UI.Menu.CloseAll()
					if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory') then
						ESX.UI.Menu.CloseAll()
					else
					local isopen = GetVehicleDoorAngleRatio(vehicle,5)
					  if locked == 1 or IsPedHuman(vehicle) then
							if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
								CloseToVehicle = true
								SetVehicleDoorOpen(vehFront, 5, false)
								Citizen.Wait(500)
								TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
								TriggerServerEvent('esx_truck_inventory:AddVehicleList', globalplate)
								TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
							end
						  elseif class == 10 or class == 20 or class == 15 or class == 16 or class == 14 then
						  ESX.UI.Menu.CloseAll()
						  if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							CloseToVehicle = true
							TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
							TriggerServerEvent('esx_truck_inventory:AddVehicleList', globalplate)
							TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
						  end
					  else
					   ESX.ShowNotification('Vehicle ~r~Locked')
					  end
					end
				else
					--ESX.ShowNotification('No ~r~Vehicle ~w~ nearbye')
				end
				lastOpen = true
				GUI.Time  = GetGameTimer()
			else
				TriggerEvent('esx:showNotification', "~y~Someone already in trunk")
			end
		end, globalplate)
	end

end
local count = 0
-- Key controls
Citizen.CreateThread(function()
  while true do
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local vehFront = VehicleInFront()
    Wait(0)
    if ( IsControlJustReleased( 0, 303 ) or IsDisabledControlJustReleased( 0, 303 ) ) and GetLastInputMethod( 0 )then
	  if closecar ~= nil then
		if count == 0 then
			openmenuvehicle()
			count = count +1
		else
			Wait(2000)
			count = 0
		end
		end
    elseif lastOpen and IsControlPressed(0, Keys["BACKSPACE"]) and (GetGameTimer() - GUI.Time) > 150 then
	  CloseToVehicle = false
      lastOpen = false
      if lastVehicle > 0 then
		local lastvehicleplatetext = GetVehicleNumberPlateText(lastVehicle)
		TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', lastvehicleplatetext)
      	lastVehicle = 0
		Citizen.Wait(1500)
	  SetVehicleDoorShut(vehFront, 5, false)
      end
      GUI.Time  = GetGameTimer()
    end
	
  end
end)

-- CloseToVehicle
Citizen.CreateThread(function()
  while true do

    Wait(0)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	if CloseToVehicle then
		local vehicle = GetClosestVehicle(pos['x'], pos['y'], pos['z'], 2.0, 0, 70)
		if DoesEntityExist(vehicle) then
			CloseToVehicle = true
		else
			TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', globalplate)
			CloseToVehicle = false
			lastOpen = false
			ESX.UI.Menu.CloseAll()
			Citizen.Wait(500)
	  SetVehicleDoorShut(vehFront, 5, false)
		end
	end
  end
end)



RegisterNetEvent('esx_truck_inventory:getInventoryLoaded')
AddEventHandler('esx_truck_inventory:getInventoryLoaded', function(inventory,weight)
	local elements = {}
	local vehFrontBack = VehicleInFront()
  TriggerServerEvent("esx_truck_inventory:getOwnedVehicule")

	table.insert(elements, {
      label     = 'Deposit',
      count     = 0,
      value     = 'deposit',
    })

	if inventory ~= nil and #inventory > 0 then
		for i=1, #inventory, 1 do
		if inventory[i].type == 'item_standard' then
		      table.insert(elements, {
		        label     = inventory[i].label .. ' x' .. inventory[i].count,
		        count     = inventory[i].count,
		        value     = inventory[i].name,
				type	  = inventory[i].type
		      })			
			elseif inventory[i].type == 'item_weapon' then
			  table.insert(elements, {
				label     = inventory[i].label .. ' | Ammunition: ' .. inventory[i].count,
				count     = inventory[i].count,
				value     = inventory[i].name,
				type	  = inventory[i].type
			  })	
			elseif inventory[i].type == 'item_account' then
			  table.insert(elements, {
				label     = inventory[i].label .. ' [ $' .. inventory[i].count..' ]',
				count     = inventory[i].count,
				value     = inventory[i].name,
				type	  = inventory[i].type
			  })	
			end
		end
	end
	
	

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'inventory_deposit',
	  {
	    css		 = 'vehicleinventory',
	    title    = 'Vehicle Contents',
	    align    = 'bottom-right',
	    elements = elements,
	  },
	  function(data, menu)
	  	if data.current.value == 'deposit' then
	  		local elem = {}
			-- xPlayer.getAccount('black_money').money
			-- table.insert(elements, {label = 'Argent sale: ' .. inventory.blackMoney, type = 'item_account', value = 'black_money'})
			
	  		PlayerData = ESX.GetPlayerData()
			for i=1, #PlayerData.accounts, 1 do
				if PlayerData.accounts[i].name == 'black_money' then
				  -- if PlayerData.accounts[i].money > 0 then
				    table.insert(elem, {
				      label     = PlayerData.accounts[i].label .. ' [ $'.. math.floor(PlayerData.accounts[i].money+0.5) ..' ]',
				      count     = PlayerData.accounts[i].money,
				      value     = PlayerData.accounts[i].name,
				      name      = PlayerData.accounts[i].label,
					  limit     = PlayerData.accounts[i].limit,
					  type		= 'item_account',
				    })
				  -- end
				end
			end
			
			for i=1, #PlayerData.inventory, 1 do
				if PlayerData.inventory[i].count > 0 then
				    table.insert(elem, {
				      label     = PlayerData.inventory[i].label .. ' x' .. PlayerData.inventory[i].count,
				      count     = PlayerData.inventory[i].count,
				      value     = PlayerData.inventory[i].name,
				      name      = PlayerData.inventory[i].label,
					  limit     = PlayerData.inventory[i].limit,
					  type		= 'item_standard',
				    })
				end
			end
			
		local playerPed  = GetPlayerPed(-1)
		local weaponList = ESX.GetWeaponList()

		for i=1, #weaponList, 1 do

		  local weaponHash = GetHashKey(weaponList[i].name)

		  if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			table.insert(elem, {label = weaponList[i].label .. ' [' .. ammo .. ']',name = weaponList[i].label, type = 'item_weapon', value = weaponList[i].name, count = ammo})
		  end

		end
		

			ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'inventory_player',
			  {
				css		 = 'vehicleinventory',
			    title    = 'Deposit into vehicle',
			    align    = 'bottom-right',
			    elements = elem,
			  },function(data3, menu3)
				ESX.UI.Menu.Open(
				  'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
				  {
				    title = 'Quantity'
				  },
				  function(data4, menu4)
            local quantity = tonumber(data4.value)
            local Itemweight =tonumber(getItemyWeight(data3.current.value)) * quantity
            local totalweight = tonumber(weight) + Itemweight
            vehFront = VehicleInFront()

            local typeVeh = GetVehicleClass(vehFront)
            if totalweight > Config.VehicleLimit[typeVeh] then
              max = true
            else
              max = false
            end

            ownedV = 0
            while vehiclePlate == '' do
              Wait(1000)
            end
            for i=1, #vehiclePlate do
				tplate = (vehiclePlate[i].plate .. " ")
              if tplate == GetVehicleNumberPlateText(vehFront) then
                ownedV = 1
                break
              else
                ownedV = 0
              end
            end

            --fin test

            if quantity > 0 and quantity <= tonumber(data3.current.count) and vehFront > 0  then
              local MaxVh =(tonumber(Config.VehicleLimit[typeVeh])/1000)
              local Kgweight =  totalweight/1000
              if not max then
              	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  				    	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

              --  VehicleMaxSpeed(closecar,totalweight,Config.VehicleLimit[GetVehicleClass(closecar)])

  				TriggerServerEvent('esx_truck_inventory:addInventoryItem', GetVehicleClass(closecar), GetDisplayNameFromVehicleModel(GetEntityModel(closecar)), GetVehicleNumberPlateText(vehFront), data3.current.value, quantity, data3.current.name, data3.current.type, ownedV)
                ESX.ShowNotification('Trunk capacity : ~g~'.. Kgweight .. ' lbs / '..MaxVh..' lbs')
				Citizen.Wait(500)
				TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
				ClearPedTasks(GetPlayerPed(-1))
              else
                ESX.ShowNotification('You have reached the limit ~r~ '..MaxVh..' lbs')
              end
			else
				ESX.ShowNotification('~r~Quantity invalide')
			end

				    ESX.UI.Menu.CloseAll()

				  end,
				  function(data4, menu4)
				    ESX.UI.Menu.CloseAll()
					local lastvehicleplatetext = GetVehicleNumberPlateText(vehFrontBack)
					TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', lastvehicleplatetext)
				  end
				)
			end,
				function(data, menu)
					menu.close()
					ESX.UI.Menu.CloseAll()
					ClearPedTasks(GetPlayerPed(-1))
				end)
		elseif data.current.type == 'cancel' then
			menu.close()
			ESX.UI.Menu.CloseAll()
			ClearPedTasks(GetPlayerPed(-1))
	  	else
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
			  {
			    title = 'Amount'
			  },
			  function(data2, menu2)

			    local quantity = tonumber(data2.value)
				PlayerData = ESX.GetPlayerData()
			    vehFront = VehicleInFront()

          --test
          local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
          local poid = weight - Itemweight


			
          for i=1, #PlayerData.inventory, 1 do
			
            if PlayerData.inventory[i].name == data.current.value then
              if tonumber(PlayerData.inventory[i].limit) < tonumber(PlayerData.inventory[i].count) + quantity and PlayerData.inventory[i].limit ~= -1 then
                max = true
              else
                max = false
              end
            end
          end

          --fin test


			if quantity > 0 and quantity <= tonumber(data.current.count) and vehFront > 0 then
            if not max then
               TriggerServerEvent('esx_truck_inventory:removeInventoryItem', GetVehicleNumberPlateText(vehFront), data.current.value, data.current.type, quantity)
			   local typeVeh = GetVehicleClass(vehFront)
			   local MaxVh =(tonumber(Config.VehicleLimit[typeVeh])/1000)
			   local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
			   local totalweight = tonumber(weight) - Itemweight
			   local Kgweight =  totalweight/1000
			   ESX.ShowNotification('Trunk capacity : ~g~'.. Kgweight .. ' lbs / '..MaxVh..' lbs')
            else
              ESX.ShowNotification('~r~ You have reached the limit')
            end
			    else
			      ESX.ShowNotification('~r~ Quantity invalide')
			    end

			    ESX.UI.Menu.CloseAll()
				
	        	local vehFront = VehicleInFront()
	          	if vehFront > 0 then
	          		ESX.SetTimeout(1500, function()
	              		--TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
						ClearPedTasks(GetPlayerPed(-1))
	          		end)
	            else
	              --SetVehicleDoorShut(vehFrontBack, 5, false)
	            end
			  end,
			  function(data2, menu2)
                        ESX.UI.Menu.CloseAll()
                        local lastvehicleplatetext = GetVehicleNumberPlateText(vehFrontBack)
                        TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', lastvehicleplatetext)
                    end
                )
            end
        end,
		function(data, menu)
			menu.close()
			ESX.UI.Menu.CloseAll()
			ClearPedTasks(GetPlayerPed(-1))
		end
	)
end)


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
