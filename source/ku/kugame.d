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
module ku.kugame;
import polyplex.core;
import polyplex.math;
import ku.gameboard;
import polyplex.core.render.simplefont;
import ku.content;

public class KuGame : Game {
	public static KuGame ThisGame;

	GameBoard board;

	this() {
		super("Ku", new Rectangle(0, 0, 0, 0), true);
		ThisGame = this;
	}



	public override void Init() {
		Window.AllowResizing = true;
		this.Content.ContentRoot = "content/";
	}

	public override void LoadContent() {
		KuFont = new SpriteFontSimple(this.Content, "textures/shramp_sans");
		board = new GameBoard();
	}

	public override void Update(GameTimes game_time) {
		board.Update(game_time);
	}

	public override void Draw(GameTimes game_time) {
		Drawing.ClearColor(Color.Black);
		sprite_batch.Begin();
		board.Draw(game_time, sprite_batch);
		sprite_batch.End();
	}
}