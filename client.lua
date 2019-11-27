local hasspawned = true
local density = Config.MaxPerPlayer
local cartable = {}
local pedtable = {}
refreshrate = 1000
local peddensity = Config.peddensity
local parkedcars = Config.parkedcars
carcount = 0
pedtype = "posh"
running = false
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



Citizen.CreateThread(function()
	while true do 
	Wait(0)
	SetVehicleDensityMultiplierThisFrame(0.0)
	SetRandomVehicleDensityMultiplierThisFrame(0.0)
	SetParkedVehicleDensityMultiplierThisFrame(parkedcars)
	SetPedDensityMultiplierThisFrame(peddensity)
	SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
	if debugmode1 == true then
drawTxt(0.300, 0.100, 0.2,0.2,0.5, "Car count  = "..carcount.."", 250, 250, 250, 255)
end


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

if running == false then
running = true
Wait(1200)
Citizen.CreateThread(function()
print"AI spawning loops"
while true do 
Wait(refreshrate) 
 carcount = Tablelength(cartable)
if carcount < density or carcount < Config.Minimum then
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
RequestModel(model) 
while not HasModelLoaded(model) do
Citizen.Wait(0)
if debugmode == true then

end 
--RequestModel(model) 
end 
--Wait(0)
local chance = math.random(1,4)
local diff2 = math.random(Config.minSpawndis + 10,Config.MaxSpawndis)
if chance == 1 then
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 - diff,(diff2 + (vel * 2.0) ),0.0)
posforward = true 
elseif chance == 2 then
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 + diff,(diff2 + (vel * 2.0) ),0.0)
posforward = true 
elseif chance == 3 then
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 - diff,(-130.0 + (vel * 1.0) ),0.0)
posforward = false
else 
local diff = math.random(0,150)
coords = GetOffsetFromEntityInWorldCoords(Ped,0.0 + diff,(-130.0 + (vel * 1.0) ),0.0)
posforward = false 
end
if debugmode == true then
print("density",density)
debug2(coords)
end

a,b,h = GetClosestVehicleNodeWithHeading(coords.x,coords.y,coords.z,8,3,0)
--a,b,h = GetNthClosestVehicleNodeFavourDirection(coords.x,coords.y,coords.z,GetE,8,3,0)
players = GetActivePlayers()
local tooclose = false
local coords2 = GetEntityCoords(GetPlayerPed(-1))
local spawndis2 = GetDistanceBetweenCoords(coords2,b,false)
local pedheading = GetEntityHeading(Ped)
if spawndis2 < Config.MaxSpawndis + vel and spawndis2 > (Config.minSpawndis + vel*2) then
----if posforward == true then
--if h > pedheading - 90 and h < pedheading + 90 then
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
--[[else
if h > pedheading + 90 and h < pedheading - 90 then
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
end
end]]








if tooclose == false then
tooclose2 = false
for k,v in ipairs (cartable) do
Wait(5)
if GetDistanceBetweenCoords(GetEntityCoords(v.carid),b,false) < 35 then
tooclose2 = true
end
end		
if tooclose2 == false then

carid = CreateVehicle(model,b,h,true,0)
MT = GetOffsetFromEntityInWorldCoords(carid,3.0,0.0,0.0)
SetEntityCoords(carid, MT, false, false, false, false)
if debugmode == true then
debug3(b)
end
SetEntityAsMissionEntity(carid,1,1)
--carid2 = NetworkGetNetworkIdFromEntity(carid)
--	NetworkSetEntityCanBlend(carid,true)
--	SetNetworkIdExistsOnAllMachines(carid2, true)
--	NetworkSetNetworkIdDynamic(carid2, true)
--SetNetworkIdCanMigrate(carid2,true)
speed = 10


Wait(5)
if GetVehicleBodyHealth(carid) > 999.9 then
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
--SetEntityAsNoLongerNeeded(carid)
--SetEntityAsNoLongerNeeded(driver)
--SetVehicleForwardSpeed(carid,speed,1)	
table.insert(cartable, {carid = carid})
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
table.insert(pedtable, {pedid = driver})
end










function SetcarspeedNUL(carid)
speed = math.random(1.0,100.0)
local playercoords = GetEntityCoords(GetPlayerPed(-1))
if speedvar == 1 then   --- slow

if speed < 10 then
TaskVehicleDriveToCoordLongrange(driver,carid,playercoords,2125724159,50)
elseif speed < 20 then
TaskVehicleDriveToCoordLongrange(driver,carid,playercoords,2125724159,50)
elseif speed < 70 then
TaskVehicleDriveToCoordLongrange(driver,carid,playercoords,2125724159,50)
elseif speed < 101 then
TaskVehicleDriveToCoordLongrange(driver,carid,playercoords,2125724159,50)
end
elseif speedvar == 2 then    --- med 

if speed < 10 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,3000.0,0.0,2125724159,50)
elseif speed < 20 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,3000.0,0.0,2125724159,50)
elseif speed < 70 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,3000.0,0.0,2125724159,50)
elseif speed < 101 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,3000.0,0.0,2125724159,50)
end
elseif speedvar == 3 then             -- fast 

if speed < 10 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,2000.0,0.0,2125724159,50)
elseif speed < 20 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,3000.0,0.0,2125724159,50)
elseif speed < 70 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,3000.0,0.0,2125724159,50)
elseif speed < 101 then
TaskVehicleDriveToCoordLongrange(driver,carid,3000.0,3000.0,0.0,2125724159,50)
end
end
end




function Setcarspeed(carid)
speed = math.random(1.0,100.0)

if speedvar == 1 then   --- slow

if speed < 10 then
TaskVehicleDriveWander(driver,carid,15.0*Config.Speedmulti,447)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,20.0*Config.Speedmulti,447)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,16.0*Config.Speedmulti,447)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,17.0*Config.Speedmulti,447)
end
elseif speedvar == 2 then    --- med 

if speed < 10 then
TaskVehicleDriveWander(driver,carid,16.0*Config.Speedmulti,447)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,20.0*Config.Speedmulti,447)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,22.0*Config.Speedmulti,447)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,24.0*Config.Speedmulti,447)
end
elseif speedvar == 3 then             -- fast 

if speed < 10 then
TaskVehicleDriveWander(driver,carid,34.0*Config.Speedmulti,447)
elseif speed < 20 then
TaskVehicleDriveWander(driver,carid,27.0*Config.Speedmulti,447)
elseif speed < 70 then
TaskVehicleDriveWander(driver,carid,22.0*Config.Speedmulti,447)
elseif speed < 101 then
TaskVehicleDriveWander(driver,carid,24.0*Config.Speedmulti,447)
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
		Wait(500)
		  		if Tablelength(pedtable) > 0 then
			for k,v in pairs (pedtable) do
			Wait(10)
				if DoesEntityExist(v.pedid) == false then
				table.remove(pedtable, k)
				if debugmode == true then
				print"ped missing remove ped from table"
				end
				elseif IsPedInAnyVehicle(v.pedi,false) then
				table.remove(pedtable, k)
				if debugmode == true then
				print"ped not in car remove ped from table"
				end
				end
				end
				end
  		if Tablelength(cartable) > 0 then
			for k,v in pairs (cartable) do
				if DoesEntityExist(v.carid) == false then
				table.remove(cartable, k)
				if debugmode == true then
				print"clear missing car form table"
				end

				else
				local curcarid = v.carid
	local carcoords = GetEntityCoords(v.carid)			
				tooclose = false
				cleared = false
					for k,v in pairs (players) do
if cleared == false then					
					Wait(10) 
				
					--otherplayer = GetPlayerPed(v)
					local coords2 = GetEntityCoords(GetPlayerPed(v))

					local deldis =  GetDistanceBetweenCoords(coords2,carcoords,false)		
					--print(deldis)
					--if IsPedInAnyVehicle(v,false) then
					--print"bing1"
					--if GetVehicleClass(GetVehiclePedIsIn(v,false)) == 18 then
					--print"bing2"
					if deldis < 80 then 
				
						driverped = GetPedInVehicleSeat(curcarid,-1)
						SetEntityAsNoLongerNeeded(curcarid)
						SetEntityAsNoLongerNeeded(driverped)
						elseif deldis > 80 then 
						driverped = GetPedInVehicleSeat(curcarid,-1)
						SetEntityAsMissionEntity(curcarid,1,1)
						SetEntityAsMissionEntity(driverpedr,1,1)
					end		
				
					
					
						if deldis < Config.Deldis then
						
						tooclose = true
						
						end
						--print(IsVehicleSeatFree(curcarid,-1))
						if IsVehicleSeatFree(curcarid,-1) == true and deldis > Config.Deldis*0.3then  
						SetEntityAsNoLongerNeeded(curcarid)
						table.remove(cartable, k)
						cleared = true
						if debugmode == true then
						print"ped not in car - remove car"
						end
						end

				
						end
						
						end
						if tooclose == false then
						driverped = GetPedInVehicleSeat(curcarid,-1)
						SetEntityAsNoLongerNeeded(curcarid)
						SetEntityAsNoLongerNeeded(driverped)
						table.remove(cartable, k)
						cleared = true
				if debugmode == true then
				print"car far away Remove"
				end
				
						end
					end
				end
			end
		end
end)

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
    DrawText(x , y )
end
