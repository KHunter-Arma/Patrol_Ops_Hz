//class CfgSounds {

        sounds[] = {nuke1s, nuke2s, radzoneb, nblast, incoming};

	class nuke1s
	{
		name = "nuke1s"; // Name for mission editor
		sound[] = {\lk\sound\nuke1s.wss, db + 100, 1.0};
		titles[] = {0, ""};
	};
	class nuke2s
	{
		name = "nuke2s"; // Name for mission editor
		sound[] = {\lk\sound\nuke2s.wss, db + 10, 1.0};
		titles[] = {0, ""};
	};
	class radzoneb
	{
		name = "radzoneb"; // Name for mission editor
		sound[] = {\lk\sound\radiation.ogg, db + 0, 1.0};
		titles[] = {0, ""};
	};
	class incoming
	{
		name = "incoming"; // Name for mission editor
		sound[] = {\lk\sound\incoming.ogg, db + 0, 1.0};
		titles[] = {0, ""};
	};
	class nblast
	{
		name = "nblast"; // Name for mission editor
		sound[] = {\lk\sound\tom.wss, db + 2, 1.0};
		titles[] = {0, ""};
	};
        
        
	class IncomingTask {
		name="IncomingTask";
		sound[]={"mps\media\incoming_task.wss",db,1.0};
		titles[] = {};
	};
        
        class Intro {
        
                name="Intro";
		sound[]={"media\intro.ogg",db,1.0};
		titles[] = {};
        };
        
        class Outro {
        
                name="Outro";
		sound[]={"media\outro.ogg",db,1.0};
		titles[] = {};
        };
        
        class shout  {
            
        name     = "AllahAkbar";
        sound[]  = {"media\shout.ogg",1,1,200};
        titles[] = {};
        };
        
                class pain1  {
            
        name     = "pain1";
        sound[]  = {"media\pain1.ogg",0.025,1};
        titles[] = {};
        };
        
                class pain2  {
            
        name     = "pain2";
        sound[]  = {"media\pain2.ogg",0.025,1};
        titles[] = {};
        };
        
                class pain3  {
            
        name     = "pain3";
        sound[]  = {"media\pain3.ogg",0.025,1};
        titles[] = {};
        };
        
        //Not sure if it's JSRS but arty sounds could be heard from very far away with gain 20...
        
        //new: was 0.01
         class arty1  {
            
        name     = "arty1";
        sound[]  = {"media\arty1.ogg",1,1};
        titles[] = {};
        };
        
                class arty2  {
            
        name     = "arty2";
        sound[]  = {"media\arty2.ogg",1,1};
        titles[] = {};
        };
        
                class arty3  {
            
        name     = "arty3";
        sound[]  = {"media\arty3.ogg",1,1};
        titles[] = {};
        };
        
        
    
        
        
//};