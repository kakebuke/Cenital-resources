package com.gui
{
	import com.Constants;
	import com.MapEditor;
	import com.tiles.Tile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Canvas extends CanvasMC
	{
		private static const TILE_SIDE:int = 16;
		
		public function Canvas(_width:int, _height:int, _x:int, _y:int)
		{
			super();
			
			this.bg.width = _width;
			this.bg.height = _height;
			this.x = _x;
			this.y = _y;
			
			this.addEventListener(MouseEvent.CLICK, onCanvasClick);
			
			drawGrid();
		}
		
		private function drawGrid():void
		{
			var mc:MovieClip = new MovieClip();
			var lx:int = 0;
			var ly:int = 0;
			
			mc.graphics.lineStyle(1, 0xffffff, 1);
			while (lx < this.width) {
				mc.graphics.moveTo(lx,0);
				mc.graphics.lineTo(lx, this.height);
				lx += TILE_SIDE;
			}
			while (ly < this.height) {
				mc.graphics.moveTo(0, ly);
				mc.graphics.lineTo(this.width, ly);
				ly += TILE_SIDE;
			}
			this.addChild(mc);
		}
		
		protected function onCanvasClick(event:MouseEvent):void
		{
			var mc:MovieClip = event.currentTarget as MovieClip;
			var tileX:int = mc.mouseX / TILE_SIDE;
			var tileY:int = mc.mouseY / TILE_SIDE;
			
			trace(event.currentTarget.toString());
			trace("canvas clicked in position x: " + MovieClip(event.currentTarget).mouseX + ", y: " + MovieClip(event.currentTarget).mouseY);
			trace("tile should be: tx: " + tileX + ", ty: " + tileY);
			
			if (MapEditor.self.state == Constants.STATE_PLACE_TILE) {
				var tile:Tile = MapEditor.self.selectedTile;
				MapEditor.self.tilePlaced(new Point(tileX, tileY), tile);
				var newTile:Tile = this.addChild(new Tile(tile.type)) as Tile;
				newTile.x = tileX * Constants.TILE_WIDTH;
				newTile.y = tileY * Constants.TILE_HEIGHT;
			}
		}
	}
}