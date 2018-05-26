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
module ku.gameboard;
import polyplex.core;
import polyplex.math;
import ku.content;
import std.conv;

import polyplex.core.render.gl.debug2d;

import polyplex.utils.random;
import std.stdio;
import std.array;
import ku.kugame;

public struct Block {
	public ubyte[3][3] Data;

	this(Random rand) {
		foreach(y; 0 .. 3) {
			foreach(x; 0 .. 3) {
				bool success = false;
				while (!success) {
					ubyte val = (((cast(ubyte)rand.Next())%9)+1);
					if (!Has(val)) {
						success = true;
						Data[x][y] = val;
					}
				}
			}
		}
	}

	public bool Has(ubyte val) {
		foreach(vp; Data) {
			foreach(v; vp) {
				if (v == val) return true;
			}
		}
		return false;
	}
}

public Block[3][3] GenBoard(Random rng) {
	Block[3][3] o_dat;
	foreach (y; 0 .. 3) {
		foreach(x; 0 .. 3) {
			o_dat[x][y] = Block(rng);
		}
	}
	return o_dat;
}

public class GameBoard {
	public Block[3][3] BoardBlocks;
	private Vector2 measure_tape;
	public Rectangle BoardBounds;
	Random rand;
	public this() {
		rand = new Random();
		BoardBlocks = GenBoard(rand);
		measure_tape = KuFont.MeasureString("0");
	}

	public void Update(GameTimes game_time) {
		if (Keyboard.GetState().IsKeyDown(Keys.R)) BoardBlocks = GenBoard(rand);
	}

	public void Draw(GameTimes game_time, SpriteBatch sprite_batch) {
		float width = 9*measure_tape.X;
		float height = 9*measure_tape.Y;
		
		float offset_x = (KuGame.ThisGame.Window.Width/2)-(width/2);
		float offset_y = (KuGame.ThisGame.Window.Height/2)-(height/2);
		
		Color b = Color.Gray;
		Color a = new Color(112, 112, 112, 255);

		Color c = b;

		Color d = new Color(0, 0, 0, 32);

		int itr = 1;

		foreach(x; 0 .. 3) {
			foreach(y; 0 .. 3) {

				float dx = (3)*measure_tape.X;
				float dy = (3)*measure_tape.Y;
				c = b;
				if (itr % 2 == 1) c = a;

				GlDebugging2D.DrawRectangleFilled(new Rectangle(cast(int)(offset_x+(x*dx)), cast(int)(offset_y+(y*dy)), cast(int)(dx), cast(int)(dy)), c);

				GlDebugging2D.DrawLines([
					Vector2(offset_x+(x*dx), offset_y+(y*dy)),
					Vector2(offset_x+((x+1)*dx), offset_y+(y*dy)),
					Vector2(offset_x+((x+1)*dx), offset_y+((y+1)*dy)),
					Vector2(offset_x+(x*dx), offset_y+((y+1)*dy)),
					Vector2(offset_x+(x*dx), offset_y+(y*dy)),
				], Color.White);
				int iterx = 1;
				foreach(pX; 0 .. 3) {
					foreach(pY; 0 .. 3) {

						if (iterx % 2 == 1) GlDebugging2D.DrawRectangleFilled(new Rectangle(cast(int)(offset_x+((x*dy)+((pX)*measure_tape.X))), cast(int)(offset_y+((y*dx)+((pY)*measure_tape.Y))), cast(int)(measure_tape.X), cast(int)(measure_tape.Y)), d);
						KuFont.DrawString(sprite_batch, BoardBlocks[x][y].Data[pX][pY].text, Vector2(offset_x+((x*dy)+((pX)*measure_tape.X)), offset_y+((y*dx)+((pY)*measure_tape.Y))), 1f, Color.Yellow);
						iterx++;
					}
				}
				itr++;
			}
		}
	}
}