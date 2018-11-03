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


//};