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
pedmod = getRandomPed()
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


local peds = {'a_m_m_acult_01','a_m_m_afriamer_01','a_m_m_beach_01','a_m_m_beach_02','a_m_m_bevhills_01','a_m_m_bevhills_02','a_m_m_business_01','a_m_m_eastsa_01','a_m_m_eastsa_02','a_m_m_farmer_01','a_m_m_fatlatin_01','a_m_m_genfat_01','a_m_m_genfat_02','a_m_m_golfer_01','a_m_m_hasjew_01','a_m_m_hillbilly_01','a_m_m_hillbilly_02','a_m_m_indian_01','a_m_m_ktown_01','a_m_m_malibu_01','a_m_m_mexcntry_01','a_m_m_mexlabor_01','a_m_m_og_boss_01','a_m_m_paparazzi_01','a_m_m_polynesian_01','a_m_m_prolhost_01','a_m_m_rurmeth_01','a_m_m_salton_01','a_m_m_salton_02','a_m_m_salton_03','a_m_m_salton_04','a_m_m_skater_01','a_m_m_skidrow_01','a_m_m_socenlat_01','a_m_m_soucent_01','a_m_m_soucent_02','a_m_m_soucent_03','a_m_m_soucent_04','a_m_m_stlat_02','a_m_m_tennis_01','a_m_m_tourist_01','a_m_m_trampbeac_01','a_m_m_tramp_01','a_m_m_tranvest_01','a_m_m_tranvest_02','a_m_o_acult_01','a_m_o_acult_02','a_m_o_beach_01','a_m_o_genstreet_01','a_m_o_ktown_01','a_m_o_salton_01','a_m_o_soucent_01','a_m_o_soucent_02','a_m_o_soucent_03','a_m_o_tramp_01','a_m_y_acult_01','a_m_y_acult_02','a_m_y_beachvesp_01','a_m_y_beachvesp_02','a_m_y_beach_01','a_m_y_beach_02','a_m_y_beach_03','a_m_y_bevhills_01','a_m_y_bevhills_02','a_m_y_breakdance_01','a_m_y_busicas_01','a_m_y_business_01','a_m_y_business_02','a_m_y_business_03','a_m_y_cyclist_01','a_m_y_dhill_01','a_m_y_downtown_01','a_m_y_eastsa_01','a_m_y_eastsa_02','a_m_y_epsilon_01','a_m_y_epsilon_02','a_m_y_gay_01','a_m_y_gay_02','a_m_y_genstreet_01','a_m_y_genstreet_02','a_m_y_golfer_01','a_m_y_hasjew_01','a_m_y_hiker_01','a_m_y_hippy_01','a_m_y_hipster_01','a_m_y_hipster_02','a_m_y_hipster_03','a_m_y_indian_01','a_m_y_jetski_01','a_m_y_juggalo_01','a_m_y_ktown_01','a_m_y_ktown_02','a_m_y_latino_01','a_m_y_methhead_01','a_m_y_mexthug_01','a_m_y_motox_01','a_m_y_motox_02','a_m_y_musclbeac_01','a_m_y_musclbeac_02','a_m_y_polynesian_01','a_m_y_roadcyc_01','a_m_y_runner_01','a_m_y_runner_02','a_m_y_salton_01','a_m_y_skater_01','a_m_y_skater_02','a_m_y_soucent_01','s_m_m_doctor_01','s_m_m_fiboffice_02','s_m_m_gaffer_01','s_m_m_gardener_01','s_m_m_gentransport','s_m_m_hairdress_01','s_m_m_highsec_01','s_m_m_highsec_02','s_m_m_janitor','s_m_m_lathandy_01','s_m_m_lifeinvad_01','s_m_m_linecook','s_m_m_lsmetro_01','s_m_m_mariachi_01','s_m_m_migrant_01','s_m_m_movprem_01','s_m_m_movspace_01','s_m_m_pilot_01','s_m_m_pilot_02','s_m_m_postal_01','s_m_m_postal_02','s_m_m_scientist_01','s_m_m_strperf_01','s_m_m_strpreach_01','s_m_m_strvend_01','s_m_m_trucker_01','s_m_m_ups_01','s_m_m_ups_02','s_m_o_busker_01','s_m_y_airworker','s_m_y_ammucity_01','s_m_y_armymech_01','s_m_y_autopsy_01','s_m_y_barman_01','s_m_y_baywatch_01','s_m_y_busboy_01','s_m_y_chef_01','s_m_y_clown_01','s_m_y_construct_01','s_m_y_construct_02','s_m_y_dealer_01','s_m_y_devinsec_01','s_m_y_dockwork_01','s_m_y_dwservice_01','s_m_y_dwservice_02','s_m_y_factory_01','s_m_y_garbage','s_m_y_grip_01','s_m_y_mime','s_m_y_pestcont_01','s_m_y_pilot_01','s_m_y_prismuscl_01','s_m_y_prisoner_01','s_m_y_robber_01','s_m_y_shop_mask','s_m_y_strvend_01','s_m_y_uscg_01','s_m_y_valet_01','s_m_y_waiter_01','s_m_y_winclean_01','s_m_y_xmech_01','s_m_y_xmech_02','u_m_m_aldinapoli','u_m_m_bankman','u_m_m_bikehire_01','u_m_m_fibarchitect','u_m_m_filmdirector','u_m_m_glenstank_01','u_m_m_griff_01','u_m_m_jesus_01','u_m_m_jewelsec_01','u_m_m_jewelthief','u_m_m_markfost','u_m_m_partytarget','u_m_m_promourn_01','u_m_m_rivalpap','u_m_m_spyactor','u_m_m_willyfist','u_m_o_finguru_01','u_m_o_taphillbilly','u_m_o_tramp_01','u_m_y_abner','u_m_y_antonb','u_m_y_babyd','u_m_y_baygor','u_m_y_burgerdrug_01','u_m_y_chip','u_m_y_cyclist_01','u_m_y_fibmugger_01','u_m_y_guido_01','u_m_y_gunvend_01','u_m_y_hippie_01','u_m_y_imporage','u_m_y_justin','u_m_y_mani','u_m_y_militarybum','u_m_y_paparazzi','u_m_y_party_01','u_m_y_pogo_01','u_m_y_prisoner_01','u_m_y_proldriver_01','u_m_y_rsranger_01','u_m_y_sbike','u_m_y_staggrm_01','u_m_y_tattoo_01', 'a_f_m_beach_01','a_f_m_bevhills_01','a_f_m_bevhills_02','a_f_m_bodybuild_01','a_f_m_business_02','a_f_m_downtown_01','a_f_m_eastsa_01','a_f_m_eastsa_02','a_f_m_fatbla_01','a_f_m_fatcult_01','a_f_m_fatwhite_01','a_f_m_ktown_01','a_f_m_ktown_02','a_f_m_prolhost_01','a_f_m_salton_01','a_f_m_skidrow_01','a_f_m_soucentmc_01','a_f_m_soucent_01','a_f_m_soucent_02','a_f_m_tourist_01','a_f_m_trampbeac_01','a_f_m_tramp_01','a_f_o_genstreet_01','a_f_o_indian_01','a_f_o_ktown_01','a_f_o_salton_01','a_f_o_soucent_01','a_f_o_soucent_02','a_f_y_beach_01','a_f_y_bevhills_01','a_f_y_bevhills_02','a_f_y_bevhills_03','a_f_y_bevhills_04','a_f_y_business_01','a_f_y_business_02','a_f_y_business_03','a_f_y_business_04','a_f_y_eastsa_01','a_f_y_eastsa_02','a_f_y_eastsa_03','a_f_y_epsilon_01','a_f_y_fitness_01','a_f_y_fitness_02','a_f_y_genhot_01','a_f_y_golfer_01','a_f_y_hiker_01','a_f_y_hippie_01','a_f_y_hipster_01','a_f_y_hipster_02','a_f_y_hipster_03','a_f_y_hipster_04','a_f_y_indian_01','a_f_y_juggalo_01','a_f_y_runner_01','a_f_y_rurmeth_01','a_f_y_scdressy_01','a_f_y_skater_01','a_f_y_soucent_01','a_f_y_soucent_02','a_f_y_soucent_03','a_f_y_tennis_01','a_f_y_topless_01','a_f_y_tourist_01','a_f_y_tourist_02','a_f_y_vinewood_01','a_f_y_vinewood_02','a_f_y_vinewood_03','a_f_y_vinewood_04','a_f_y_yoga_01','cs_tracydisanto','cs_tanisha', 'cs_patricia', 'cs_mrsphillips', 'cs_mrs_thornhill', 'cs_natalia', 'cs_molly', 'cs_movpremf_01', 'cs_maryann', 'cs_michelle', 'cs_marnie', 'cs_magenta', 'cs_janet', 'cs_jewelass', 'cs_guadalope', 'cs_gurk',  'cs_debra', 'cs_denise', 'cs_amandatownley',  'cs_ashley', 'csb_screen_writer', 'csb_stripper_01', 'csb_stripper_02', 'csb_tonya', 'csb_maude', 'csb_denise_friend', 'csb_abigail', 'csb_anita', 'g_f_y_ballas_01','g_f_y_families_01','g_f_y_lost_01','g_f_y_vagos_01','s_f_m_fembarber','s_f_m_maid_01','s_f_m_shop_high','s_f_m_sweatshop_01','s_f_y_airhostess_01','s_f_y_bartender_01','s_f_y_baywatch_01','s_f_y_factory_01','s_f_y_hooker_01','s_f_y_hooker_02','s_f_y_hooker_03','s_f_y_migrant_01','s_f_y_movprem_01','s_f_y_shop_low','s_f_y_shop_mid','s_f_y_stripperlite','s_f_y_stripper_01','s_f_y_stripper_02','s_f_y_sweatshop_01','u_f_m_corpse_01','u_f_m_miranda','u_f_m_promourn_01','u_f_o_moviestar','u_f_y_spyactress'}

function getRandomPed()
 local model = GetHashKey(peds[math.random(1,#peds)])
 RequestModel(model)
 while not HasModelLoaded(model) do
  Citizen.Wait(10)
 end
 return model
end
