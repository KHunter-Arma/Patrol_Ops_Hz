switch (toUpper worldName) do {

	case "FALLUJAH" : {
				
			//Get rid of nasty trees or rocks in the middle of the road
			{
				{_x hideObject true} foreach _x;
			}foreach [
						nearestobjects [[3339.92,4055.99,0.00143862],[],15],
						nearestobjects [[3359.98,4055.47,0.00143862],[],15],
						nearestobjects [[3043.59,2721.69,0.00143862],[],15],
						nearestobjects [[3699.2,4940.73,0.00143862],[],15],
						nearestobjects [[9561.9,3168.5,0],[],5],
						nearestobjects [[1218.63,5087.15,0],[],3],
						nearestobjects [[1257.83,5962.05,0],[],3],
						nearestobjects [[1369.4,5431.94,0],[],3],
						nearestobjects [[1036.81,6507.57,0],[],3],
						nearestobjects [[833.191,4872.68,0],[],3],
						nearestobjects [[9563.39,3220.3,0],[],3],
						nearestobjects [[7485.19,1546.53,0],[],3],
						nearestobjects [[7457.34,1578.68,0],[],3],
						nearestobjects [[7407.9,1693.95,0],[],3],
						nearestobjects [[7295.93,1837.87,0],[],3],
						nearestobjects [[7225.26,1928.44,0],[],3],
						nearestobjects [[6881.5,2198.52,0],[],3],
						nearestobjects [[6082.23,2437.86,0],[],3],
						nearestobjects [[6245.35,2440.68,0],[],3],
						nearestobjects [[5888.09,2423.78,0],[],3],
						nearestobjects [[5806.42,2418.46,0],[],3],
						nearestobjects [[5712.85,2411.32,0],[],3],
						nearestobjects [[5709.63,2402.85,0],[],3],
						nearestobjects [[5639.17,2406.44,0],[],3]
					];
					
		
			_loc = createLocation ["NameVillage", [4105.2,7885.61], 1600, 700];
			_loc setText "Mukhtar village";
			
			_loc = createLocation ["NameVillage", [761.528,9569.74], 800, 800];
			_loc setText "Saqlawiyah";
			
			_loc = createLocation ["NameVillage", [9045.93,9493.81], 1000, 900];
			_loc setText "Al-Sejar";
			
			_loc = createLocation ["NameVillage", [1820.37,3573.13], 900, 1500];
			_loc setText "Zawiyah";
			
			_loc = createLocation ["NameVillage", [387.451,2209.49], 500, 1100];
			_loc setText "Halabsah";
	
	};
	
	default {};

};