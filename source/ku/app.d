/*
    ku
    Copyright (C) 2018  Clipsey

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

*/
module ku.app;
import std.stdio;
import core.sys.posix.sys.types;
import core.sys.posix.unistd;
import polyplex.core;
import polyplex;
import ku.kugame;

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
