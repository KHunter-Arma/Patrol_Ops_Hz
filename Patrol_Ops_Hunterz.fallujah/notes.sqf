if(isDedicated || (call Hz_fnc_isHC)) exitWith{};

player createDiarySubject ["patrol1","Patrol Brief"];
player createDiarySubject ["patrol2","Patrol Wiki"];

player createDiaryRecord ["patrol2", [ "Respawn" , "
When you die, you will see a black screen and a notification telling you that you are dead. It takes several minutes for you to respawn, which is much longer than the standard in Arma or any other game. Use this time to relax a little bit and maybe browse the web to pass those few minutes more quickly. Chat is disabled in-game for a reason, it's best not to bother your teammates by writing to them using other means, because they might be in a tight situation and they probably wouldn't want anything to break their concentration. When you respawn, you have the option to deploy at base or at your rallypoint in the FOB (if deployed).
" ]];

player createDiaryRecord ["patrol2", [ "Missions with spawned objects" , "
Some missions will require you to transport objects to some location. To do this, you must go to the ""Main Depot"" inside base (check your map) with a truck. You can load these objects into trucks and then transport them.<br/>
<br/>
In some missions you need to deploy towers or other objects. These objects will initially spawn as containers and can be setup by moving the container to a location and selecting the ""Deploy Tower"" option.<br/>
<br/>
In some other missions, you might be asked to transport things back to base. In this case, take them back to the ""Main Depot"".
" ]];

player createDiaryRecord ["patrol2", [ "Mission" , "
Missions are requested by B.A.D. PMC team leaders.<br/>
Some missions are required to be completed within a certain amount of time, or they will be failed and you might even be punished for it!<br/>
" ]];

player createDiaryRecord ["patrol2", [ "Using Map Markers" , "
Using map markers are essential in Patrol Ops Hunter'z, as they allow for coordination not just within your team, but also with players that will join the server after you leave.<br/>
<br/>
It is very important to mark things like abandoned friendly vehicles, friendly and enemy infrastructure (read about the enemy air radar below) or task-related objects, and even your FOB, if you build one.<br/>
<br/>
Another use for markers might be naming nearby streets or infrastructure to make it easier to coordinate operations when talking on the radio. You can even use markers to relay information by text to other units; this can simulate data transmission services available to modern military radios. Just make sure you delete any markers that have no use.<br/>
<br/>
IT IS A VERY COMMON MISTAKE TO FORGET TO SWITCH TO GLOBAL CHANNEL BEFORE PLACING YOUR MARKERS! MAKE SURE YOU DO THAT OR ONLY YOU WILL SEE YOUR MARKERS!<br/>
<br/>
Placing coloured markers or different types of markers:<br/>
When placing a marker, after you double click it and when you're entering the name, you can use your Up and Down arrow keys to cycle through different types of markers. Use Shift + Up or Shift + Down arrow to cycle through different colours.<br/>
" ]];

player createDiaryRecord ["patrol2", [ "Random Patrols" , "
Patrol Ops Hunter'z is designed as a persistent mission (refer to the briefing notes for more info). There is a continuous battle going on in the background, separate from the tasks. Random patrols, both enemy and friendly, will be circling the AO at all times. Patrols range from infantry squads, to motorised or mechanised infantry, to air patrols.<br/>
<br/>
Beware, for air patrols in Patrol Ops Hunter'z can be even more dangerous than anything else! Read the section about the enemy air radar in the notes for more information on enemy air patrols.<br/>
" ]];

player createDiaryRecord ["patrol2", [ "Enemy Air Radar" , "
A key asset for the enemy, the air radar coordinates enemy air patrols. The radar will be in a random place, usually in some remote location. If you find it, it is a very good idea to destroy it! It will be defended though!<br/>
<br/>
If you manage to find and destroy the air radar, enemy air support will be severly crippled. They will not be able to send out any air patrols for a long time. This not only means the skies will be more clear, but also friendly patrols will have an easier time and might take control of the AO and make things easier for you. Eventually though, enemies will build another radar in another location!<br/>
Also, destroying the enemy radar tower does not guarantee that the enemy won't send air units as reinforcements during tasks." ]];

player createDiaryRecord ["patrol2", [ "Building a FOB" , "
In Patrol Ops Hunter'z, you may decide to build a FOB, which can be very helpful for logistics. However, in order to have a functional FOB, you need to make sure you deploy the following objects:<br/>
<br/>
<br/>
- FOB HQ<br/>
<br/>
- A flag<br/>
<br/>
- You can add extra functions to your FOB, by also deploying a medical tent or field hospital and Barracks for AI recruitment.<br/>
<br/>
- There is a large selection of fortifications available to defend the FOB. Just visit Hunter'z Fortification Store in base to browse the available items.<br/>
<br/>
- Once you build a functional FOB, you can deploy your rallypoint in the vicinity which will give you the option to spawn there. Rallypoints stay persistent when you re-connect to the server later, however they can be destroyed.<br/>
<br/>
A FOB can be very useful, but at the same time it can be costly and time-consuming to maintain. However FOBs are essential especially in larger maps.
" ]];

/*
player createDiaryRecord ["patrol2", [ "Lifting Vehicles" , "
Large utility helicopters such as the Merlin or Chinook are capable of lifting light vehicles, ie. cars and jeeps.<br/>
<br/>
To Lift: take a slingrope and attach it to the vehicle by using the interaction menu. Then, interact with the vehicle again to attach the slingrope to the chopper. The chopper must be less than 10 metres away from the vehicle for it to work, and the vehicle must be empty.<br/>
<br/>
IMPORTANT!!! Do NOT interact with the chopper, it will show you the option to attach the rope, but it will be greyed out (known ACE bug). Always interact with the vehicle to get it working properly!<br/>
<br/>
IMPORTANT!!! If there is a heavy vehicle like a tank or APC near the chopper, your interaction menu will be disabled. This is how ACE prevents you from lifting vehicles that are too heavy with choppers, it is not a bug! You will not be able to use your interaction menu in this case while near the chopper!<br/>
<br/>
The C130 is able to lift all vehicles and can airdrop them at high altitude. The vehicle doesn't need to be empty to be loaded. The pilot has control over loading and unloading vehicles.<br/>
<br/>
The parachute will deploy when the vehicle reaches an altitude of less than 750m, however it will take a few seconds for the vehicle to slow down. Therefore you should drop the vehicle from at least 800m altitude to be safe.<br/>
<br/>
When the vehicle lands, it will deploy orange smoke and blue and yellow flares so troops on the ground can locate it easily in the day or at night. It will deploy blue smoke and flares again after 1 minute.
" ]];
*/
player createDiaryRecord ["patrol2", [ "Important Vehicle Information" , "
In Hunter'z Patrol Ops, vehicles do not respawn, instead you buy them from Hunter'z Vehicle Store. This means that vehicles are extremely valuable in this mission, as more advanced vehicles are very expensive. It is imperative to recover damaged vehicles and return them to base or if that is not possible, to mark its location on the map using the Side Channel, so that your team can keep on using them or recover them at a later time.<br /><br />Many vehicles that look similar have a different armament and a different purpose. You should decide what vehicle you need for your mission, or if you need any at all. You shouldn't use vehicles for your own needs. For example, if you die, use an ATV to get to your team-mates, instead of wasting a HMMWV or a chopper.<br /><br />Use markers on Side Channel, to mark locations of disabled friendly vehicles, or friendly mines placed on the ground. This way anyone who joins the server can see where these are. Make sure you return the vehicles you use to the base or the FOB (if you build one) before disconnecting.</t>
" ]];

player createDiaryRecord ["patrol2", [ "Injury System" , "
Hunter'z Patrol Ops uses an advanced system for wounds and injuries. If you're heavily wounded you might not even be able to bandage yourself, so you must always call a medic when wounded.<br/>
<br/>
" ]];
/*
player createDiaryRecord ["patrol2", [ "IEDs" , "
IEDs (if enabled) will be a danger to all ground forces moving around the AO.<br/>
Only visibly detectable, an IED can cause a lot of damage to vehicles and their crew.<br/>
<br/>
If you spot a potential IED, stop the vehicle, approach on foot and attempt to either Defuse or Detonate it. Only then will it be safe to proceed.<br/>
It is not advisable to leave them as they will still pose a threat to other vehicles.
" ]];
*/
player createDiaryRecord ["patrol2", [ "Civilian Commands" , "
You can order civilians to perform many actions such as getting down, or clearing the area. You can even order them to get out of their vehicles if you look at their vehicle!<br/>
<br/>
Just hold down ""shift"" and use your scroll wheel to access the civilian commands menu.<br/>
" ]];
/*
player createDiaryRecord ["patrol2", [ "Recruiting AI" , "
You can recruit AI units at the Barracks next to the Medical Facility at base (or at the FOB if deployed).<br/>
<br/>
To recruit units: select the option at the barracks and select from the unit types available<br/>
To dismiss units: walk up to the unit and select the ""Dismiss"" action to delete the unit.<br/>
<br/>
If you get killed while commanding AI units, you might loose command of them when you respawn. You can 
use the ""st_interact"" addon to overcome this problem and have the ability to re-take command.<br/>
<br/>
AI units can also be very useful to defend the FOB if you build one. However, make sure you don't leave any AI inside vehicles, or they might take them and run away!!!<br/>
<br/>
ALWAYS MAKE SURE YOU DISMISS YOUR AI UNITS BEFORE DISCONNECTING (UNLESS YOU PLACE THEM AS GUARDS IN THE FOB) OR YOU WILL PUT MORE LOAD ON THE SERVER BECAUSE THEY WILL NOT BE REMOVED AUTOMATICALLY!
" ]];
*/
player createDiaryRecord ["patrol1", [ "Credits" , format["
Patrol Operations Hunter'z - %1<br/>
<br/>
Special thanks to members of B.A.D. PMC at Bad Company Gaming Community for their support and testing of Patrol Ops Hunter'z which has been vital in its success.<br/>
<br/>
All Hunter'z modifications either made or implemented by K.Hunter of Bad Company. I could never have done it without the awesome community this game has, and of course my whole inspiration comes from ACE, ACRE and their developers. Kudos to those guys! My special thanks go to EightySix for all his awesome work and ideas that have been put into this mission and I especially thank him for doing his work so tidily and professionally which has made it much easier to modify.<br/>
<br/>
Special thanks to:<br/>
- Bad Company Gaming Community<br/>
- BON_IF for a lot of Code, Support and Inspiration from Takistan Force<br/>
- XENO for Code and Inspiration from Domination 2<br/>
- Code34 for Advanced Hint System and adaption of Vehicle/squad Hud<br/>
- [OCB]Kev for his knowledge and code examples<br/>
- Shuko for Task System and Position<br/>
- R3F for Respawn GUI and Logistics Code<br/>
- ArmA Community for support, inspiration and solutions<br/>
",toUpper worldname] ]];

player createDiaryRecord ["patrol1", [ "Gameplay" , format["
Patrol Operations - %1<br/>
<br/>
Key to Patrol Ops is to work as a team and have a strategy when approaching the objectives.<br/>
Missions are random and the enemy aren't always going to be exactly where you expect them to be. Don't always trust map markers placed by the task. With some tasks, the actual objective location will be in that area, but not exactly on the marker and might be as far as 1km away. You can talk to civilians who might help you locate objectives.<br/>
<br/>
Random patrols are always circling the map and they might have other surprises for you too, so always stay on your toes while outside of base!
<br/>
Another piece of advice: never trust civilians! Civilians are civilians as long as they are not armed, but there might always be some sinister ones that carry weapons, in which case they are no longer civilians, so be on the lookout and order civilians to get down if they are close to you. If you kill innocent civilians, you will be punished and you will lose respawns. This might cause you to fail the task very quickly. The worst thing that can happen though, is that if you kill too many innocent civilians, you can cause a rebellion and the local population will take up arms against you!<br/>
<br/>
Remember to scan, advance and secure your locations as the enemy and their strength is random and even the mission maker cannot tell you exactly what to expect.
",toUpper worldname] ]];

player createDiaryRecord ["patrol1", [ "Brief" , format["
Patrol Operations Hunter'z - %1<br/>
Patrol Ops is a dynamic, random mission series. Patrol Ops Hunter'z is a heavily modded version of the original mission and focuses especially on realism and on creating a more challenging and dynamic environment in-game.<br/>
<br/>
AI are modified to achieve a more realistic and challenging behaviour and the environment is persistent.<br/>
<br/>
A focus on co-operative teamplay is the principle of Patrol Ops and of Hunter'z modifications. On behalf of Bad Company Gaming Community (www.BadCompanyPMC.com), I hope you enjoy Patrol Ops Hunter'z<br/>By K.Hunter
",toUpper worldname] ]];