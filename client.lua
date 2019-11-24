local hasspawned = true
local density = Config.MaxPerPlayer
local cartable = {}
local peddensity = Config.peddensity
local parkedcars = Config.parkedcars


AddEventHandler('playerSpawned', function()
startupspawn()
hasspawned = true
hasspawnednow = true
end)
Citizen.CreateThread(function()
	if debugrestart == true then
	startupspawn()
	hasspawned = true
	hasspawnednow = true
	end
end)



Citizen.CreateThread(function()
	while true do 
	Wait(0)
	SetVehicleDensityMultiplierThisFrame(0.0)
	SetRandomVehicleDensityMultiplierThisFrame(0.0)
	SetParkedVehicleDensityMultiplierThisFrame(parkedcars)
	SetPedDensityMultiplierThisFrame(peddensity)
	SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)

	end
end)

Citizen.CreateThread(function()
	if hasspawned == false then 
		repeat
		Wait(5000)
			if hasspawned == true then
			hasspawnednow = true
			end
		until hasspawnednow == true
	end
	while true do 
	Wait(3000)
	local pedcoords = GetEntityCoords(GetPlayerPed(-1))
	isinsandy = false
	isintown = false
	isinpaleto = false
	isinposhcity = false
		if GetDistanceBetweenCoords(pedcoords,517.15,-2816.5,44.2,false) < 700 or GetDistanceBetweenCoords(mapcoords,2357.15,2242.5,65.2,false) < 600  then 
		isinindustrial = true
		density = Config.MaxPerPlayer*0.1
		elseif GetDistanceBetweenCoords(pedcoords,1620.15,3663.11,33.2,false) < 1300 then    ---- sandy    
		density = Config.MaxPerPlayer*0.5
		isinsandy = true
		elseif GetDistanceBetweenCoords(pedcoords,-807.15,216.11,75.2,false) < 1300 then  --- posh town 
		density = Config.MaxPerPlayer*0.8
		isinposhcity = true
		elseif GetDistanceBetweenCoords(pedcoords,24.15,-770.60,44.2,false) < 2000 then
		isintown = true
		density = Config.MaxPerPlayer
		else
		density = Config.MaxPerPlayer*0.3
		end
		local closeplayers = 0
		local targetCoords1 = GetEntityCoords(GetPlayerPed(-1))
		local players = GetActivePlayers()

	peddensity = Config.peddensity
	parkedcars = Config.parkedcars
		for k,v in pairs (players) do	
		Wait(50) 
		targetCoords = GetEntityCoords(GetPlayerPed(v))	
		closeplayers = closeplayers + 1					
	--	local targetCoords = GetEntityCoords(GetPlayerPed(players[k]))	
			if GetDistanceBetweenCoords(targetCoords, targetCoords1, true) < Config.DisToHalf then
			density = (density / closeplayers)
			peddensity = (peddensity / closeplayers)
			parkedcars = (parkedcars / closeplayers)
			end
		end
	end
end)

function startupspawn()
Citizen.CreateThread(function()
while true do 
Wait(12) 
if debugmode == true then
print(Tablelength(cartable))
end
if Tablelength(cartable) < density or Tablelength(cartable) < Config.Minimum then
Wait(0)
local Ped = GetPlayerPed(-1)
if IsPedInAnyVehicle(Ped,true) then
vel = GetVehicleWheelSpeed(GetVehiclePedIsIn(Ped,false),1)
else
vel = 0
end
repeat
Wait(0)
model = Carlist()
until model ~= nil
--if model ~= nil then ---- pick car 
Wait(0)
local chance = math.random(1,4)
local diff2 = math.random(Config.minSpawndis,Config.MaxSpawndis)
if chance == 1 then
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 - diff,(diff2 + (vel * 2.0) ),0.0)
elseif chance == 2 then
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 + diff,(diff2 + (vel * 2.0) ),0.0)
elseif chance == 3 then
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 - diff,(-130.0 + (vel * 1.0) ),0.0)
else 
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 + diff,(-130.0 + (vel * 1.0) ),0.0)
end
if debugmode == true then
print("density",density)
debug2(coords)
end
a,b,h = GetClosestVehicleNodeWithHeading(coords.x,coords.y,coords.z,8,3,0)
players = GetActivePlayers()
local tooclose = false
local coords2 = GetEntityCoords(GetPlayerPed(-1))
local spawndis2 = GetDistanceBetweenCoords(coords2,b,false)
if spawndis2 < Config.MaxSpawndis + vel and spawndis2 > (Config.minSpawndis + vel/2) then
for k,v in pairs (players) do	
Wait(0) 
local coords = GetEntityCoords(GetPlayerPed(v))
if GetDistanceBetweenCoords(coords,b,false) < (Config.minSpawndis2 + vel) then
tooclose = true 
end 
end
else
tooclose = true
end
if tooclose == false then
Wait(0)

RequestModel(model) 
while not HasModelLoaded(model) do
Citizen.Wait(1000)
if debugmode == true then

end 
--RequestModel(model) 
end 
tooclose2 = false
for k,v in ipairs (cartable) do
Wait(15)
if GetDistanceBetweenCoords(GetEntityCoords(v.carid),b,false) < 50 then
tooclose2 = true
end
end		
if tooclose2 == false then
carid = CreateVehicle(model,b,h,true, 0)
if debugmode == true then
debug3(b)
end
SetEntityAsMissionEntity(carid,1,1)
carid2 = NetworkGetNetworkIdFromEntity(carid)
--	NetworkSetEntityCanBlend(carid,true)
--	SetNetworkIdExistsOnAllMachines(carid2, true)
--	NetworkSetNetworkIdDynamic(carid2, true)
SetNetworkIdCanMigrate(carid2,true)
speed = 10
pedmod = 549978415
RequestModel(pedmod)
while not HasModelLoaded(pedmod) do
Citizen.Wait(1)
end
SetVehicleForwardSpeed(carid,16,1)
Wait(12)
if GetVehicleBodyHealth(carid) > 999.9 then
Setcarspeed(carid)
SetVehicleEngineOn(carid,true,true,true)
pedid = NetworkGetNetworkIdFromEntity(driver)
--NetworkSetEntityCanBlend(driver,true)
--SetNetworkIdExistsOnAllMachines(pedid, true)
--NetworkSetNetworkIdDynamic(pedid, true)
SetNetworkIdCanMigrate(pedid,true)
--SetEntityAsNoLongerNeeded(carid)
--SetEntityAsNoLongerNeeded(driver)
--SetVehicleForwardSpeed(carid,speed,1)
		
table.insert(cartable, {carid = carid})
Wait(10)
end
else
SetModelAsNoLongerNeeded(model)
end
end
Wait(0)
else
SetModelAsNoLongerNeeded(model)
--end
end
end
end)
end

function Setcarspeed(carid)
speed = math.random(1,100)
SetVehicleForwardSpeed(carid,speed,1)
if speedvar == 1 then   --- slow
driver = CreatePedInsideVehicle(carid,4,pedmod,-1,1,262144)
if speed < 10 then
TaskVehicleDriveWander(driver,carid,15.0,191)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,20.0,191)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,16.0,191)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,17.0,191)
end
elseif speedvar == 2 then    --- med 
driver = CreatePedInsideVehicle(carid,4,pedmod,-1,1,262144)
if speed < 10 then
TaskVehicleDriveWander(driver,carid,16.0,191)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,20.0,191)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,22.0,191)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,24.0,191)
end
elseif speedvar == 3 then             -- fast 
driver = CreatePedInsideVehicle(carid,4,pedmod,-1,1,262144)
if speed < 10 then
TaskVehicleDriveWander(driver,carid,34.0,191)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,27.0,191)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,22.0,191)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,24.0,191)
end
end
end

function Carlist()
math.randomseed(GetGameTimer())
areaset = false
if isintown == true then    -- town center
areaset = true
speedvar = 1
CC = math.random(1,11)
model = citycars[CC].id
--print("chance",CC)
return(model)
end
if isinposhcity == true then    -- town posh
areaset = true
speedvar = 1
CC = math.random(1,11)
model = poshcitycars[CC].id
--print("chance2",CC)
return(model)
end
if isinsandy == true then    -- sand shores
areaset = true
 CC = math.random(1,27)
model = sandycars[CC].id
speedvar = 2
return(model)
end
if isinindustrial == true then   -- S E Industrial docks 
areaset = true
math.randomseed(GetGameTimer())
 CC = math.random(2,21)
model = industrialcitycars[CC].id
speedvar = 3
return(model)
end

if areaset == false then -- just in case no area is found 
math.randomseed(round(GetGameTimer()/4))
 CC = math.random(2,58)
model = elsecars[CC].id
speedvar = 3

return(model)
end
end
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function debug1()
Citizen.CreateThread(function()








end)
end
function debug2(coords2)
Citizen.CreateThread(function()
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)  
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0) 
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)  
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)   
   DrawMarker(1, coords2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0) 






end)
end
function debug3(b2)
Citizen.CreateThread(function(b2)
print"spawning car"
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
 Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
Wait(0)
 DrawMarker(1, b2, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
end)
end

---if player in car remover from list 
Citizen.CreateThread(function()
if hasspawned == false then 
repeat
Wait(5000)
if hasspawned == true then
hasspawnednow = true
end
until hasspawnednow == true
end
	while true do 
		Wait(5500)
		ped = GetPlayerPed(-1)
vic = GetVehiclePedIsIn(ped,true)


for k,v in pairs (cartable) do
Wait(100)
if vic == v then
table.remove(cartable, k)
end
end

end
end)

Citizen.CreateThread(function()
local tooclose = false
	while true do 
		Wait(1500)
  		if Tablelength(cartable) > 0 then
			for k,v in pairs (cartable) do
				if DoesEntityExist(v.carid) == false then
				table.remove(cartable, k)
				else
	local carcoords = GetEntityCoords(v.carid)			
				tooclose = false
					for k,v in pairs (players) do	
					Wait(0) 
					--otherplayer = GetPlayerPed(v)
					local coords2 = GetEntityCoords(GetPlayerPed(v))

					local deldis =  GetDistanceBetweenCoords(coords2,carcoords,false)		
					--print(deldis)
					
						if deldis < Config.Deldis then
						tooclose = true

						end
					end
						if tooclose == false then
						driverped = GetPedInVehicleSeat(v.carid,-1)
						SetEntityAsNoLongerNeeded(v.carid)
						SetEntityAsNoLongerNeeded(driverped)
						table.remove(cartable, k)
						end
					end
				end
			end
		end
end)

	function Tablelength(T)
    local count = 0
    for _ in pairs(T) do
	Wait(0)
	count = count + 1 
	end
----print("count",count)
	--print(count)
	if count == 0 then
	--planttable = {}
	end
	--print("count",count)
    return count - 1

end
	
	function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
