Garrison script by zorilya

This script will allow you to make a more lively urban environment where you have to check every window and door in every house
rather than having in the back of your mind 'it's arma, AI don't go in buildings very well'. the units you put into buildings
will remain there pretty well under fire but if you get bogged down they will come to you so bust in a clear 'em out.
you can also use this to liven up a patrol route by setting the waypoint init with the script so the group gets there and garrisons a nearby building.


to run just use this template;
		
		 nul = [unit,radius,stationary?] execVM "Garrison_script.sqf";

where unit is the leader of the group and radius is the radius of the area he will search for buildings.

then your dudes will wait a sec and pick a building from the area at random and fill it up then pick another
and fill it and so on until there are no more buildings or no more units.

if all buildings are occupied or none are in range, the group randomly patrol around staying in the general area of the nearest building.


Please remember this makes a random choice from the buildings in an area... if you want them in a specific building just set the radius really small 
and move the leader really close to the building. works a treat :)


you may Improve on this design so long as there is atleast a mention of the source and obviously that you share so we can all benifit.

works with vanilla AI and ASR AI (haven't tested others yet).
i would go so far as to say that this works more consitantly under vanilla however i personally use ACE and have had very few issues

enjoy

suggested for fun !

		add about 12 enemy groups into a building heavy area and run the garrison on all of the leaders setting the radius to about 50m.

		try and kill them all it's quick to set up and a ton of fun.

Stress test:
		I have run this on 24 groups (with 10 or more units each. 240 units give or take) and had a further 40 units without it on my PC, not a dedicated server and saw a minimal drop in performance. 
		320 runing this killed it for me though, FPS was noticably down. I have no doubt this is just because i was hosting and playing on the same machine.

known issues : 
		currently using a silenced weapon doesn't effect the range at which the enemies can hear you unless your using ACE2.
		i am looking for a better way and a more universal way of checking if a weapon is silenced or not.
		
		celle buildings present a problem which through testing i believe to be pathfinding related. 

		as of yet i have not added a way to mark buildings unoccupied when units leave. however i haven't 
		found a time yet where i need that really badly so i wouldn't say it's gonna impact using this too much.


Changelog v1.6

Added : new optional Variables (capacity limit and warping) for more customised use of the script. 
	index 3 accepts an array for capacity with two number enries [percentage,maximum].

	percentage is the percentage of positions to fill of buildings encountered rounded up.
	maximum is the maximum number of units to enter any building. 0 sets no limit.
	
	default : [60,0]

	index 4 accepts a boolean to control whether or not the units will walk into position.
	if true they just teleport or 'warp' handy for a tidy mission start or dealing with that awkward
	pathing problem.

	default : false	
	
Added : new AI check to help AI recognise a door as a possible entry point for enemies.
Changed : silenced check for arma 3 so it now works as intended.
Fixed : patrol script error where units would just stop if nothing was around.

Changelog v1.5.1
hotfix

Fixed : sorted roaming problem caused by unstable variable. roaming now works as intended.
changed : Tweaked the willwalk.sqf to improve roaming.

Changelog v1.5

Added : cqc reaction funtions. Units are now more aware of enemies when they fire round close by and look in a logical direction.
Added : garrisoned units can now move inside buildings, improving randomness of the environment.

Changed : 4 man limit to patrol groups then next group is made and so on.
Changed : many other little optimisations.

Changelog v1.4 

Added : indoors check to control behaviour i.e. crouching on roofs and balconys (works better than the old top third check);
Added : check for watch towers (and other buiildings) to avoid 3 units garrisoning the one tower (who makes a one man watch tower with 3 positions? who does that?)
Added : vision obscured check to stop units looking in useless directions.

Changed : increased time that script waits for a patrol group before exiting to 4 minutes to handle yet more pathfinding issues.


changelog v1.3

added : small tweak so that units look around a little more, it's random!
added : height check relative to building so that units now crouch when on roofs. balconys and overhangs that are not the top of a building are a liitle hit and miss.
added : persitance to getting into position. pathfinding being as problematic as it can be, a unit will try a few times to get into position before givin up and joining a patrol group.

changed : no longer required the World_build_list.sqf or any other over arching variables. This means you can nowuse in on any map!
Changed : optimised the script since the first change making it on average 3 seconds faster when executing (less standing around looking gormless).
Changed : Improved the checks for occuppied buildings to ensure even less doubling up when garrisoning with multiple groups in the same area (seems to only mess up when i accellerate time hehe).
changed : better system for patrol script to loop (doesn't constantly call the script anymore);

Removed : all world buildings lists. no need for them any more.
Removed : annoying debug hints that are no longer needed thanks to patrol script.

changelog v1.2

added : redesigned building check to include an occupied variable so as to avoid different groups garrisoning the same building.
added : patrol script. if all buildings are occupied or none are in range, the group randomly partol around staying in the general area of the nearest building.

changelog v1.1

added : compatibility with more islands
added : randomiser for stationary command
 