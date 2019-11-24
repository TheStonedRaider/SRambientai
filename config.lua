Config                            = {}
   --- 
Config.MaxPerPlayer = 15 --------- How many cars are spawned per player, 
------ this is halfed when near another player whis a minimum of 2 car per player. 
Config.Minimum = 1 -------- How many cars are spawned per player

Config.DisToHalf = 250   ---- Distance to another player to reduce the MaxPerPlayer count.


Config.peddensity = 0.5     ------------ Density of peds minimum = 0.0 max = 1.0
------ this devided by the amount of players near  you
Config.parkedcars = 0.5        ----------- Density of parked cars  minimum = 0.0 max = 1.0
------ this devided by the amount of players near  you




Config.minSpawndis = 130   ----- Minimum spawning distance from player

Config.MaxSpawndis = 300   ----- Maximum spawning distance from player 

Config.minSpawndis2 = 130 ----- Minimum spawning distance from  other players (best kept the same as Config.minSpawndis

Config.Deldis = 325 ----- Distance that cars will be set as no longer needed ! Always keep this higher than - Config.MaxSpawndis 


-------------------Debug mode!
debugrestart = false   --- Set TRUE if restarting script when server is running 

debugmode =  false  --- shows the search and spawn spots 


	 citycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 741090084},
	{['id'] = -5153954},
	{['id'] = -391594584},
	{['id'] = -624529134},
	{['id'] = 1348744438},
	{['id'] = -1930048799},
	{['id'] = -1122289213},
	{['id'] = 1549126457},
	{['id'] = -1177863319},
	{['id'] = -1130810103},
	{['id'] = 1032823388},
	}
	 poshcitycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 704435172},
	{['id'] = 633712403},
	{['id'] = 1274868363},
	{['id'] = 767087018},
	{['id'] = -1041692462},
	{['id'] = 2072687711},
	{['id'] = -1045541610},
	{['id'] = -2022483795},
	{['id'] = 108773431},
	{['id'] = -566387422},
	{['id'] = -1995326987},
	{['id'] = -1566741232},
	{['id'] = -1089039904},
	{['id'] = -1405937764},
	{['id'] = -1297672541},
	{['id'] = 482197771},
	{['id'] = -142942670},
	{['id'] = -1934452204},
	{['id'] =  -674927303},
	{['id'] =  -1255452397},
	{['id'] = 1922255844},
	{['id'] = -746882698},
	{['id'] = -1757836725},
	{['id'] = 1886268224},
	{['id'] = 1102544804},
	{['id'] = 117401876},
	{['id'] = 108773431},
	{['id'] = 784565758},
	{['id'] = 1051415893},
	{['id'] = -1660945322},
	{['id'] = 1011753235},
	{['id'] = 223240013},
	{['id'] = -433375717},
	{['id'] = 1545842587},
	{['id'] = 75889561},
	{['id'] = -1291952903},
	{['id'] = 1426219628},
	{['id'] = -1696146015},
	{['id'] = 1234311532},
	{['id'] = 418536135},
	{['id'] = 2123327359},
	{['id'] = -1829802492},
	{['id'] = -1758137366},
	{['id'] = 1987142870},
	{['id'] = 819197656},
	{['id'] = 1663218586},
	{['id'] = 2067820283},
	{['id'] = 408192225},
	{['id'] = 338562499},
	{['id'] = -1622444098},
	{['id'] = 989294410},
	{['id'] = -1403128555},
	{['id'] = -2048333973},
	{['id'] = -1776615689},

	}
	 hoodcitycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 58485},
	{['id'] = 58485},
	{['id'] = 58485},
	{['id'] = 58485},

	
	}
	 industrialcitycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 2053223216},
	{['id'] = 2112052861},
	{['id'] = 569305213},
	{['id'] = -2052737935},
	{['id'] = 1917016601},
	{['id'] = 516990260},
	{['id'] = 2132890591},
	{['id'] = 887537515},
	{['id'] = -599568815},
	{['id'] = -884690486},
	{['id'] = 464687292},
	{['id'] = 970598228},
	{['id'] = -746882698},
	{['id'] = -956048545},
	{['id'] = 1723137093},
	{['id'] = -2040426790},
	{['id'] = 886934177},
	{['id'] = 1770332643},
	{['id'] = 1518533038},
	{['id'] = -2137348917},
	{['id'] = 1032823388},	
	}
	 sandycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 741090084},
	{['id'] = 1531094468},
	{['id'] = 569305213},
	{['id'] = -2033222435},
	{['id'] = -624529134},
	{['id'] = 1348744438},
	{['id'] = -599568815},
	{['id'] = 1349725314},
	{['id'] = -1122289213},
	{['id'] = 1039032026},
	{['id'] = 1549126457},
	{['id'] = -1177863319},
	{['id'] = -1130810103},
	{['id'] = -2076478498},
	{['id'] = -442313018},	
	{['id'] = -537896628},
	{['id'] = 121658888},
	{['id'] = -1346687836},
	{['id'] = 1876516712},
	{['id'] = 296357396},
	{['id'] = -120287622},
	{['id'] = 1488164764},
	{['id'] = 943752001},
	{['id'] = -1776615689},
	{['id'] = 1026149675},
	{['id'] = 699456151},
	{['id'] = -1311240698},
	{['id'] = 1032823388},
	}
	local elsecars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 2053223216},
	{['id'] = 2112052861},
	{['id'] = 569305213},
	{['id'] = -2052737935},
	{['id'] = 1917016601},
	{['id'] = 516990260},
	{['id'] = 2132890591},
	{['id'] = 887537515},
	{['id'] = -599568815},
	{['id'] = -884690486},
	{['id'] = 464687292},
	{['id'] = 970598228},
	{['id'] = -746882698},
	{['id'] = -956048545},
	{['id'] = 1723137093},
	{['id'] = -2040426790},
	{['id'] = 886934177},
	{['id'] = 1770332643},
	{['id'] = 1518533038},
	{['id'] = -2137348917},
	{['id'] = 1032823388},	
	{['id'] = 741090084},
	{['id'] = -5153954},
	{['id'] = -391594584},
	{['id'] = -624529134},
	{['id'] = 1348744438},
	{['id'] = -1930048799},
	{['id'] = -1122289213},
	{['id'] = 1549126457},
	{['id'] = -1177863319},
	{['id'] = -1130810103},
	{['id'] = 1032823388},
	{['id'] = 741090084},
	{['id'] = 1531094468},
	{['id'] = 569305213},
	{['id'] = -2033222435},
	{['id'] = 1348744438},
	{['id'] = -599568815},
	{['id'] = 1349725314},
	{['id'] = -1122289213},
	{['id'] = 1039032026},
	{['id'] = 1549126457},
	{['id'] = -1177863319},
	{['id'] = -1130810103},
	{['id'] = -2076478498},
	{['id'] = -442313018},	
	{['id'] = -537896628},
	{['id'] = 121658888},
	{['id'] = -1346687836},
	{['id'] = 1876516712},
	{['id'] = 296357396},
	{['id'] = -120287622},
	{['id'] = 1488164764},
	{['id'] = 943752001},
	{['id'] = -1776615689},
	{['id'] = 1026149675},
	{['id'] = 699456151},
	{['id'] = -1311240698},
	{['id'] = 1032823388},
	}

