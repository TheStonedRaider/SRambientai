local hasspawned = true
local density = Config.MaxPerPlayer
local cartable = {}
refreshrate = 1000
local isloopon = false
local peddensity = Config.peddensity
local parkedcars = Config.parkedcars
pedtype = "posh"
pedtable = {}
	function Tl(T)
    local count = 0
    for _ in pairs(T) do
	--Wait(0)
	count = count + 1 
	end
----print("count",count)
	--print(count)
	if count == 0 then
	--planttable = {}
	end
	--print("count",count)
    return count

end
Citizen.CreateThread(function()
Wait(300)
refreshrate = Config.refreshrate
generalpedcount = Tl(generalpeds)
citycarscount = Tl(citycars)
poshcitycarscount = Tl(poshcitycars)
hoodcitycarscount = Tl(hoodcitycars)
industrialcitycarscount = Tl(industrialcitycars)
sandycarscount = Tl(sandycars)	
elsecarscount = Tl(elsecars)	
industrialpedcount = Tl(industrialpeds)
hoodpedscount = Tl(hoodpeds)
poshpedscount = Tl(poshpeds)
bumpedscount = Tl(bumpeds)	
hipsterpedcount = Tl(hipsterpeds)	
lapedscount = Tl(lapeds)
businesspedscount = Tl(businesspeds)
richpedcount = Tl(richpeds)
print("generalpedcount",generalpedcount)
	end)
	



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
carcount = 0
	print"cunt!"

Citizen.CreateThread(function()
	while true do 
	Wait(0)
	SetVehicleDensityMultiplierThisFrame(0.0)
	SetRandomVehicleDensityMultiplierThisFrame(0.0)
	SetParkedVehicleDensityMultiplierThisFrame(parkedcars)
	SetPedDensityMultiplierThisFrame(peddensity)
	SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
drawTxta(0.028,0.02,0.4,0.4,1.0, ""..carcount.."", 0,0,0,230)
drawTxta(0.028,0.04,0.4,0.4,1.0, ""..density.."", 0,0,0,230)
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
	local random1 = math.random(-150,150)
	local pedcoords = GetEntityCoords(GetPlayerPed(-1))
	isinsandy = false
	isintown = false
	isinpaleto = false
	isinposhcity = false

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
	end
			if GetDistanceBetweenCoords(pedcoords,295.15,-3093.5,44.2,false) < 900 + random1 or GetDistanceBetweenCoords(mapcoords,2357.15,2242.5,65.2,false) < 600 + random1  then 
		isinindustrial = true
		density = Config.MaxPerPlayer*Config.IndustrialMulti
		elseif GetDistanceBetweenCoords(pedcoords,1620.15,3663.11,33.2,false) < 1300 + random1 then    ---- sandy    
		density = Config.MaxPerPlayer*Config.SandyMulti
		isinsandy = true
		elseif GetDistanceBetweenCoords(pedcoords,-65.15,6312.11,31.2,false) < 1300 + random1 then    ---- paleto    
		density = Config.MaxPerPlayer*Config.PaletoMulti
		isinsandy = true
		elseif GetDistanceBetweenCoords(pedcoords,-807.15,216.11,75.2,false) < 1300 + random1 then  --- posh town 
		density = Config.MaxPerPlayer*Config.PoshCityMulti
		isinposhcity = true
		elseif GetDistanceBetweenCoords(pedcoords,24.15,-770.60,44.2,false) < 2000 + random1 then  --- city center
		isintown = true
		density = Config.MaxPerPlayer*Config.CityMulti
		else
		density = Config.MaxPerPlayer*Config.ElseAreaMulti
		end
			if GetDistanceBetweenCoords(targetCoords, targetCoords1, true) < Config.DisToHalf then
			density = (density / closeplayers)
			peddensity = (peddensity / closeplayers)
			parkedcars = (parkedcars / closeplayers)
			end
		
	end
end)

function drawTxta(x,y,width,height,scale, text, r,g,b,a)
  SetTextFont(7)
  SetTextProportional(0)
  SetTextScale(width, height)
  SetTextColour(r, g, b, a)
--  SetTextDropShadow(255, 0, 0, 0,0)
 -- SetTextEdge(0, 0, 0, 0, 0)
  --SetTextDropShadow()
  --SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x,y)
end

function startupspawn()
print"starting SRai loop"
if isloopon == false then
isloopon = true
Wait(0)
Citizen.CreateThread(function()
while true do 
Wait(refreshrate) 
if debugmode == true then
--print(Tablelength(cartable))
end
carcount = Tablelength(cartable)
if carcount < density or Tablelength(cartable) < Config.Minimum then
Wait(0)
local Ped = GetPlayerPed(-1)
if IsPedInAnyVehicle(Ped,true) then
vel = GetVehicleWheelSpeed(GetVehiclePedIsIn(Ped,false),1)
else
vel = 0
end
repeat
Wait(0)
 model,pedtype  = Carlist()
until model ~= nil and pedtype ~= nil
--if model ~= nil then ---- pick car 
Wait(0)
local chance = math.random(1,4)
local diff2 = math.random(Config.minSpawndis + 15,Config.MaxSpawndis)
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
--print("density",density)
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
for k,v in ipairs (cartable) do
Wait(15)
if GetDistanceBetweenCoords(GetEntityCoords(v.carid),b,false) < 50 then
tooclose2 = true
end
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
Wait(5)
if GetDistanceBetweenCoords(GetEntityCoords(v.carid),b,false) < 45 then
tooclose2 = true
end
end		
if tooclose2 == false then
carid = CreateVehicle(model,b,h,true, 0)
table.insert(cartable, {carid = carid})
if debugmode == true then
debug3(b)
end
--SetEntityAsMissionEntity(carid,1,1)
--carid2 = NetworkGetNetworkIdFromEntity(carid)
--	NetworkSetEntityCanBlend(carid,true)
--	SetNetworkIdExistsOnAllMachines(carid2, true)
--	NetworkSetNetworkIdDynamic(carid2, true)
--SetNetworkIdCanMigrate(carid2,true)
speed = 10


Wait(5)
--if GetVehicleBodyHealth(carid) > 999.9 then
--print("pedtype1",pedtype)
Setpedincar(pedtype)
SetVehicleForwardSpeed(carid,16)
--SetEntityVelocity(carid,10.0,16.0,10.0)
Setcarspeed(carid)
SetVehicleEngineOn(carid,true,true,true)
--pedid = NetworkGetNetworkIdFromEntity(driver)
--NetworkSetEntityCanBlend(driver,true)
--SetNetworkIdExistsOnAllMachines(pedid, true)
--NetworkSetNetworkIdDynamic(pedid, true)
--SetNetworkIdCanMigrate(pedid,true)
SetEntityAsNoLongerNeeded(carid)
SetEntityAsNoLongerNeeded(driver)
--SetVehicleForwardSpeed(carid,speed,1)	

Wait(0)
--end


else
SetModelAsNoLongerNeeded(model)
end
end

else
SetModelAsNoLongerNeeded(model)
--end
end
end
end)
end
end

function Setpedincar(pedtype)
local rndm2 = math.random(1,10)
if pedtype == "gen" then
randomped = math.random(1,generalpedcount)
pedmod = generalpeds[randomped].id
elseif pedtype == "ind" then
randomped = math.random(1,industrialpedcount)
pedmod = industrialpeds[randomped].id
elseif pedtype == "rich" then
randomped = math.random(1,richpedcount)
pedmod = richpeds[randomped].id 
elseif pedtype == "posh" then

elseif pedtype == "bum" then
randomped = math.random(1,bumpedscount)
pedmod = bumpeds[randomped].id 
elseif pedtype == "hip" then
randomped = math.random(1,hipsterpedcount)
pedmod = hipsterpeds[randomped].id 
end
RequestModel(pedmod)
while not HasModelLoaded(pedmod) do
Citizen.Wait(1)
--print("pedmode2",pedmod)
end
driver = CreatePedInsideVehicle(carid,4,pedmod,-1,1,262144)
--SetEntityAsMissionEntity(driverped,1,1)
table.insert(pedtable, {pedid = driver})
end

function Setcarspeed(carid)
speed = math.random(1.0,100.0)

if speedvar == 1 then   --- slow

if speed < 10 then
TaskVehicleDriveWander(driver,carid,15.0*Config.Speedmulti,191)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,20.0*Config.Speedmulti,191)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,16.0*Config.Speedmulti,191)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,17.0*Config.Speedmulti,191)
end
elseif speedvar == 2 then    --- med 

if speed < 10 then
TaskVehicleDriveWander(driver,carid,16.0*Config.Speedmulti,191)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,20.0*Config.Speedmulti,191)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,22.0*Config.Speedmulti,191)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,24.0*Config.Speedmulti,191)
end
elseif speedvar == 3 then             -- fast 

if speed < 10 then
TaskVehicleDriveWander(driver,carid,34.0*Config.Speedmulti,191)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,27.0*Config.Speedmulti,191)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,22.0*Config.Speedmulti,191)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,24.0*Config.Speedmulti,191)
end
end
end

function Carlist()
math.randomseed(GetGameTimer())
areaset = false
if isintown == true then    -- town center
areaset = true
speedvar = 1
CC = math.random(1,143)
model = citycars[CC].id
pedtype = citycars[CC].pedtype
--print("pedtype3",pedtype)
return model,pedtype
end
if isinposhcity == true then    -- town posh
areaset = true
speedvar = 1
CC = math.random(1,11)
model = poshcitycars[CC].id
pedtype = poshcitycars[CC].pedtype
--print("pedtype4",pedtype)
--print("chance2",CC)
return model,pedtype 
end
if isinsandy == true then    -- sand shores
areaset = true
 CC = math.random(1,27)
model = sandycars[CC].id
pedtype = sandycars[CC].pedtype
--print("pedtype5",pedtype)
speedvar = 2
return model,pedtype 
end
if isinindustrial == true then   -- S E Industrial docks 
areaset = true
math.randomseed(GetGameTimer())
 CC = math.random(2,21)
model = industrialcitycars[CC].id
pedtype = industrialcitycars[CC].pedtype
--print("pedtype6",pedtype)
speedvar = 3
return model,pedtype 
end
if areaset == false then -- just in case no area is found 
math.randomseed(round(GetGameTimer()/4))
 CC = math.random(2,58)
model = elsecars[CC].id
pedtype = elsecars[CC].pedtype
--print("pedtype7",pedtype)
speedvar = 3
return model,pedtype 
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
--[[Citizen.CreateThread(function()
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
local vic = GetVehiclePedIsIn(ped,true)


for k,v in pairs (cartable) do
Wait(100)
if vic == v then
				if debugmode == true then
				print" 5 5 5 5 5 5 5 5 5 remove car ped is in"
				--TriggerServerEvent('DEBUG'," 5 5 5 5 5 5 5 5 5 remove car ped is in",mycurid)
				end
table.remove(cartable, k)
end
end

end
end)]]

Citizen.CreateThread(function()
local tooclose = false
	while true do 
	mycurid = GetPlayerServerId(PlayerId())
		Wait(1500)
		print"test"
			for k,v in pairs (cartable) do
			Wait(30)
		
			cleared = false
				if DoesEntityExist(v.carid)  then
					print"exists"
				else
				if debugmode == true then
				--TriggerServerEvent('DEBUG'," 3 3 3 3 3 3 3 3 3 3 3  3 delete non existant car",mycurid)
				end
				table.remove(cartable, k)
			end
		end
		
			for k,v in pairs (pedtable) do
			Wait(300)
			if IsPedInAnyVehicle(v.pedid,false) == false then
			table.remove(pedtable,k)
			if debugmode == true then
				if debugmode == true then
				--TriggerServerEvent('DEBUG'," 1 1 1 1 1 1 1 1 1 ped not in car remove ped from table",mycurid)
			end		
		end
		end
		end
		
		
		
		
		
		
		
		
	end
end)

--[[Citizen.CreateThread(function()
local tooclose = false
	while true do 
	
		Wait(1000)


			for k,v in pairs (pedtable) do
			Wait(300)
			if IsPedInAnyVehicle(v.pedid,false) == false then
			if debugmode == true then
				if debugmode == true then
				--TriggerServerEvent('DEBUG'," 1 1 1 1 1 1 1 1 1 ped not in car remove ped from table",mycurid)
			end
				SetEntityAsNoLongerNeeded(v.pedid)
			--	SetModelAsNoLongerNeeded(GetEntityModel(v.pedid))		
				table.remove(pedtable, k)

				end
				end
				end
  	--	if next(cartable) ~= nil then
			for k,v in pairs (cartable) do
			Wait(30)
			cleared = false
				if DoesEntityExist(v.carid) == false then
				if debugmode == true then
				--TriggerServerEvent('DEBUG'," 3 3 3 3 3 3 3 3 3 3 3  3 Delete empty car",mycurid)
				end
				table.remove(cartable, k)


				else
				local curcarid = v.carid
	local carcoords = GetEntityCoords(v.carid)			
				 tooclose3 = false
shortestdistance = 1000
					for k,v in pairs (players) do				
					Wait(3) 
					local coords2 = GetEntityCoords(GetPlayerPed(v))

					local deldis =  GetDistanceBetweenCoords(coords2,carcoords,false)	
					
						if deldis < Config.Deldis then
						tooclose3 = true
						end



					if deldis < shortestdistance then
					shortestdistance = deldis	
					--print("shortestdistance",shortestdistance)
					end
					end

					if shortestdistance < 60 then 			
						driverped = GetPedInVehicleSeat(curcarid,-1)
						SetEntityAsNoLongerNeeded(curcarid)
						SetEntityAsNoLongerNeeded(driverped)	
						SetModelAsNoLongerNeeded(GetEntityModel(driverped))	
						SetModelAsNoLongerNeeded(GetEntityModel(curcarid))				
					end	
						if shortestdistance > 110 and IsVehicleSeatFree(curcarid,-1) == true or IsVehicleStuckOnRoof(curcarid) then 
						if debugmode == true then
						print" 3 3 3 3 3 33 3 3 3 3  3Delete empty car"
				--TriggerServerEvent('DEBUG'," 3 3 3 3 3 33 3 3 3 3  3Delete empty car",mycurid)
						end				
						SetEntityAsNoLongerNeeded(curcarid)
						SetModelAsNoLongerNeeded(GetEntityModel(curcarid))
						DeleteVehicle(curcarid)
						table.remove(cartable, k)
						cleared = true

						end

				
					--	end
						
						
						
						
						
						
						
						if tooclose3 == false and cleared == false then
				if debugmode == true then
				--TriggerServerEvent('DEBUG'," 4 4 4 4 4 4 4 4 4 4 car far away Remove",mycurid)
				end
						driverped = GetPedInVehicleSeat(curcarid,-1)
						SetEntityAsNoLongerNeeded(curcarid)
						DeleteVehicle(curcarid)
						SetEntityAsNoLongerNeeded(driverped)
						DeletePed(driverped)
						SetModelAsNoLongerNeeded(GetEntityModel(driverped))	
						SetModelAsNoLongerNeeded(GetEntityModel(curcarid))	
						table.remove(cartable, k)					

				
						end
					end
				end
		--	end
		end
end)]]

	function Tablelength(T)
    local count = 0
    for _ in pairs(T) do
	--Wait(0)
	count = count + 1 
	end
----print("count",count)
	--print(count)
	if count == 0 then
	--planttable = {}
	end
	--print("count",count)
    return count -- 1

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
    DrawText(x , y )
end
