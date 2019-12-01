Config                            = {}

Config.refreshrate = 250

Config.MaxPerPlayer = 28 --------- How many cars are spawned per player, Recomended 60 MAX 
------ this devided by the amount of players near  you down to the Set minimum 

Config.Minimum = 1     ------ will try to not let the amount of cars spawned go below this amount 

Config.peddensity = 0.5     ------------ Density of peds minimum = 0.0 max = 1.0
------ this devided by the amount of players near  you
Config.parkedcars = 0.5        ----------- Density of parked cars  minimum = 0.0 max = 1.0
------ this devided by the amount of players near  you 

Config.DisToHalf = 250   ---- Distance to antoher player to lower Density.

Config.minSpawndis = 100   ----- Minimum spawning distance from player

Config.MaxSpawndis = 290   ----- Maximum spawning distance from player 

Config.minSpawndis2 = 100 ----- Minimum spawning distance from  other players (best kept the same as Config.minSpawndis

Config.Deldis = 320 ----- Distance that cars will be set as no longer needed ! Always keep this higher than - Config.MaxSpawndis 

Config.Speedmulti = 1.0        --------- Multiplier for avarage speed of vehicles

---------------- Density Multipliers for Areas ----------------

Config.CityMulti = 1.0        ----- City center 

Config.PoshCityMulti = 0.8   ---- Rockford hills  

Config.PaletoMulti = 0.8    ---- Paleto bay  

Config.SandyMulti = 0.5   ---- Sandy Shores  

Config.IndustrialMulti = 0.4   ---- All Industrial/work areas

Config.ElseAreaMulti = 0.4    ---- Eveywhere else 


-------------------Debug mode!
debugrestart = true   --- Set true if restarting script when server is running 

debugmode =  false  --- shows the search and spawn spots 

debugmode1 =  true  --- shows the amount if cars spawned  



	 citycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 941800958,['pedtype'] = "rich"},
	{['id'] = 117401876,['pedtype'] = "rich"},
	}
	
	 poshcitycars = { --  this is the format you need to put in for your possible locations.

	{['id'] = 408192225,['pedtype'] = "rich"},
	{['id'] = 338562499,['pedtype'] = "rich"},


	}

	 hoodcitycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = 1126868326,['pedtype'] = "hood"},
	{['id'] = 523724515,['pedtype'] = "hood"},
	{['id'] = 16646064,['pedtype'] = "hood"},
	{['id'] = 2006667053,['pedtype'] = "hood"},
	{['id'] = -498054846,['pedtype'] = "hood"},
	{['id'] = -899509638,['pedtype'] = "hood"},
	{['id'] = 1119641113,['pedtype'] = "hood"},
	{['id'] = 223258115,['pedtype'] = "hood"},
	{['id'] = 941494461,['pedtype'] = "hood"},
	{['id'] = -1685021548,['pedtype'] = "hood"},
	{['id'] = -227741703,['pedtype'] = "hood"},
	{['id'] = 1507916787,['pedtype'] = "hood"},
	{['id'] = 525509695,['pedtype'] = "hood"},
	{['id'] = -1790546981,['pedtype'] = "hood"},
	{['id'] = 723973206,['pedtype'] = "hood"},
	{['id'] = 1361687965,['pedtype'] = "hood"},
	{['id'] = -1205801634,['pedtype'] = "hood"},
	{['id'] = 1039032026,['pedtype'] = "gen"},
	{['id'] = -591651781,['pedtype'] = "gen"},
	{['id'] = 1549126457,['pedtype'] = "gen"},
	{['id'] = -1130810103,['pedtype'] = "gen"},
	{['id'] = 1682114128,['pedtype'] = "gen"},
	{['id'] = -1177863319,['pedtype'] = "gen"},
	{['id'] = -431692672,['pedtype'] = "gen"},
	{['id'] = -1450650718,['pedtype'] = "gen"},
	{['id'] = 841808271,['pedtype'] = "gen"},
	{['id'] = 330661258,['pedtype'] = "gen"},
	{['id'] = -5153954,['pedtype'] = "gen"},
	{['id'] =  -591610296,['pedtype'] = "gen"},
	{['id'] = -391594584,['pedtype'] = "gen"},
	{['id'] = -624529134,['pedtype'] = "gen"},
	{['id'] = 1348744438,['pedtype'] = "gen"},
	{['id'] = -511601230,['pedtype'] = "gen"},
	{['id'] = 1349725314,['pedtype'] = "gen"},
	{['id'] = 873639469,['pedtype'] = "gen"},
	{['id'] = 1581459400,['pedtype'] = "gen"},
	{['id'] = -1930048799,['pedtype'] = "gen"},
	{['id'] = -1122289213,['pedtype'] = "gen"},
	{['id'] = 1353720154,['pedtype'] = "ind"},
	{['id'] = -2107990196,['pedtype'] = "gen"},
	{['id'] = 475220373,['pedtype'] = "gen"},
	{['id'] = -1705304628,['pedtype'] = "gen"},
	{['id'] = 48339065,['pedtype'] = "gen"},
	{['id'] = 1672195559,['pedtype'] = "gen"},
	{['id'] = 86520421,['pedtype'] = "gen"},
	{['id'] = 11251904,['pedtype'] = "gen"},
	{['id'] = 390201602,['pedtype'] = "gen"},
	{['id'] = 1753414259,['pedtype'] = "gen"},
	{['id'] = -1289178744,['pedtype'] = "gen"},
	{['id'] = 640818791,['pedtype'] = "gen"},
	{['id'] = -893578776,['pedtype'] = "gen"},
	{['id'] = 788045382,['pedtype'] = "gen"},
	{['id'] = -609625092,['pedtype'] = "gen"},
	{['id'] = -1353081087,['pedtype'] = "gen"},
	{['id'] = -1205801634,['pedtype'] = "gen"},
	{['id'] = -682211828,['pedtype'] = "gen"},
	{['id'] = -1013450936,['pedtype'] = "gen"},
	{['id'] = 349605904,['pedtype'] = "gen"},
	{['id'] = 80636076,['pedtype'] = "gen"},
	{['id'] = -915704871,['pedtype'] = "gen"},
	{['id'] = 723973206,['pedtype'] = "gen"},
	{['id'] = -326143852,['pedtype'] = "gen"},
	{['id'] = -2119578145,['pedtype'] = "gen"},
	{['id'] = -1800170043,['pedtype'] = "gen"},
	{['id'] = 37348240,['pedtype'] = "gen"},
	{['id'] = 2068293287,['pedtype'] = "gen"},
	{['id'] = 525509695,['pedtype'] = "gen"},
	{['id'] = 1896491931,['pedtype'] = "gen"},
	{['id'] = -1943285540,['pedtype'] = "gen"},
	{['id'] = -2095439403,['pedtype'] = "gen"},
	{['id'] = 1507916787,['pedtype'] = "gen"},
	{['id'] = -589178377,['pedtype'] = "gen"},
	{['id'] = -227741703,['pedtype'] = "gen"},
	{['id'] = -1685021548,['pedtype'] = "gen"},
	{['id'] = 729783779,['pedtype'] = "gen"},
	{['id'] = 833469436,['pedtype'] = "gen"},
	{['id'] = 1923400478,['pedtype'] = "gen"},
	{['id'] = -401643538,['pedtype'] = "gen"},
	{['id'] = 972671128,['pedtype'] = "gen"},
	{['id'] = -825837129,['pedtype'] = "gen"},
	{['id'] = -498054846,['pedtype'] = "gen"},
	{['id'] = 2006667053,['pedtype'] = "gen"},
	{['id'] = 1126868326,['pedtype'] = "gen"},
	{['id'] = 1126868326,['pedtype'] = "gen"},
	{['id'] = -2128233223,['pedtype'] = "gen"},
	{['id'] = -1479664699,['pedtype'] = "gen"},
	{['id'] = 1770332643,['pedtype'] = "gen"},
	{['id'] = -1435919434,['pedtype'] = "gen"},
	{['id'] = -2064372143,['pedtype'] = "gen"},
	{['id'] = 1645267888,['pedtype'] = "gen"},
	{['id'] = -2045594037,['pedtype'] = "gen"},
	{['id'] = -1189015600,['pedtype'] = "gen"},
	{['id'] = 850565707,['pedtype'] = "gen"},
	{['id'] = -808831384,['pedtype'] = "gen"},
	{['id'] = 142944341,['pedtype'] = "gen"},
	{['id'] = 2006918058,['pedtype'] = "gen"},
	{['id'] = 683047626,['pedtype'] = "gen"},
	{['id'] = 1177543287,['pedtype'] = "gen"},
	{['id'] = -1137532101,['pedtype'] = "gen"},
	{['id'] = -1775728740,['pedtype'] = "gen"},
	{['id'] = -1543762099,['pedtype'] = "gen"},
	{['id'] = 884422927,['pedtype'] = "gen"},
	{['id'] = 1269098716,['pedtype'] = "gen"},
	{['id'] = -808457413,['pedtype'] = "gen"},
	{['id'] = 1337041428,['pedtype'] = "gen"},
	{['id'] = 1221512915,['pedtype'] = "gen"},
	{['id'] = 1221512915,['pedtype'] = "gen"},
	{['id'] = -1809822327,['pedtype'] = "gen"},
	{['id'] = -1903012613,['pedtype'] = "gen"},
	{['id'] = 906642318,['pedtype'] = "gen"},
	{['id'] = -2030171296,['pedtype'] = "gen"},
	{['id'] = -685276541,['pedtype'] = "gen"},
	{['id'] = -1241712818,['pedtype'] = "gen"},
	{['id'] = 1909141499,['pedtype'] = "gen"},
	{['id'] = 886934177,['pedtype'] = "gen"},
	{['id'] = -1883869285,['pedtype'] = "gen"},
	{['id'] = -1150599089,['pedtype'] = "gen"},
	{['id'] = -14495224,['pedtype'] = "gen"},
	{['id'] = 627094268,['pedtype'] = "gen"},
	{['id'] = -1477580979,['pedtype'] = "gen"},
	{['id'] = 1723137093,['pedtype'] = "gen"},
	{['id'] = -1894894188,['pedtype'] = "gen"},
	{['id'] = -1008861746,['pedtype'] = "gen"},
	{['id'] = 1373123368,['pedtype'] = "gen"},
	{['id'] = 1777363799,['pedtype'] = "gen"},
	{['id'] = -1098802077,['pedtype'] = "gen"},

	
	}

	 industrialcitycars = { --  this is the format you need to put in for your possible locations.
	{['id'] = -1098802077,['pedtype'] = "gen"},
	{['id'] = -956048545,['pedtype'] = "gen"},
	}

	 sandycars = { --  this is the format you need to put in for your possible locations.

	{['id'] = -1311240698,['pedtype'] = "sandy"},
	{['id'] = 1032823388,['pedtype'] = "sandy"},
	}
	
	 elsecars = { --  this is the format you need to put in for your possible locations.

	{['id'] = -1311240698,['pedtype'] = "gen"},
	{['id'] = 1032823388,['pedtype'] = "gen"},
	}
	
industrialpeds = { --  this is the format you need to put in for your possible locations.
	{['id'] = -294281201},
	{['id'] = 1240094341},

	}
		
		 poshpeds = { --  this is the format you need to put in for your possible locations.
	{['id'] = 00},
	{['id'] = 00},
	}	
	
	
	
			 hoodpeds = { --  this is the format you need to put in for your possible locations.
	{['id'] = 588969535},
	{['id'] = 361513884},
	{['id'] = -1492432238},
	{['id'] = 599294057},
	{['id'] = -613248456},
	{['id'] = -2077218039},
	{['id'] = 1309468115},

	}	

		
		 bumpeds = { --  this is the format you need to put in for your possible locations.
	{['id'] = 1498487404},
	
	}
	
			hipsterpeds = { --  this is the format you need to put in for your possible locations.	
	{['id'] =  -521758348},	
	{['id'] = 835315305},
	}

				lapeds = { --  this is the format you need to put in for your possible locations.
	{['id'] = 00},
	{['id'] = 00},
	{['id'] = 00},
	{['id'] = 00},
	{['id'] = 00},
	{['id'] = 00},
	{['id'] = 00},


	}

					businesspeds = { --  this is the format you need to put in for your possible locations.
					

	{['id'] = 891945583},
	{['id'] = -1717894970},
	}

					richpeds = { --  this is the format you need to put in for your possible locations.
					

	{['id'] = 891945583},
	{['id'] = -1717894970},

	}
	
					generalpeds = { --  this is the format you need to put in for your possible locations.

	{['id'] = 891945583},
	{['id'] = -1717894970},


	}

	
