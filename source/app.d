import std.stdio;
import core.sys.posix.sys.types;
import core.sys.posix.unistd;
import polyplex.core;
import polyplex;
import kugame;

void main(string[] args)
{
	uid_t id = getuid();
	if (id == 0) {
		// TODO: Start game
		BasicGameLauncher.InitSDL();
		BasicGameLauncher.LaunchGame(new KuGame(), args);
	} else {
		writeln("Sorry, this game only runs as root.\nTry: sudo ku");
	}
}
