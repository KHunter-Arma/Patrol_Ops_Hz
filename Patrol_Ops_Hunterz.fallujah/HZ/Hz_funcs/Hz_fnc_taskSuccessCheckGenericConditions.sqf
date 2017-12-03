(hz_reward > 0) 
&& 
(if(!hz_debug) then {(((count playableunits) + ({isplayer _x} count alldead)) > 1)} else {true})