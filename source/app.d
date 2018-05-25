import std.stdio;
import core.sys.posix.sys.types;
import core.sys.posix.unistd;

void main()
{
	uid_t id = getuid();
	if (id == 0) {
		// TODO: Start game
		
	} else {
		writeln("Sorry, this game only runs as root.\nTry: sudo ku");
	}
}
