Config                            = {}
   --- 
Config.MaxPerPlayer = 15 --------- How many cars are spawned per player, 
------ this is halfed when near another player whis a minimum of 2 car per player. 
Config.Minimum = 1
Config.peddensity = 0.5     ------------ Density of peds minimum = 0.0 max = 1.0
------ this is halfed when near another player 
Config.parkedcars = 0.5        ----------- Density of parked cars  minimum = 0.0 max = 1.0
------ this is halfed when near another player 

Config.DisToHalf = 250   ---- Distance 


Config.minSpawndis = 130   ----- Minimum spawning distance from player

Config.MaxSpawndis = 300   ----- Maximum spawning distance from player 

Config.minSpawndis2 = 150 ----- Minimum spawning distance from  other players (best kept the same as Config.minSpawndis

Config.Deldis = 325 ----- Distance that cars will be set as no longer needed ! Always keep this higher than - Config.MaxSpawndis 


-------------------Debug mode!
debugrestart = false   --- Set TRUE if restarting script when server is running 

debugmode =  true  --- shows the search and spawn spots 
