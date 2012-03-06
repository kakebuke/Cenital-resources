package com.gui
{
	import com.Constants;
	import com.MapEditor;
	import com.tiles.Tile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	public class Canvas extends CanvasMC
	{
		private static const TILE_SIDE:int = 16;
		private var oldTile:Point;
		private var mouseIsDown:Boolean;
		
		public function Canvas(_width:int, _height:int, _x:int, _y:int)
		{
			super();
			
			this.bg.width = _width;
			this.bg.height = _height;
			this.x = _x;
			this.y = _y;
			
			this.mouseIsDown = false;
			
			this.addEventListener(MouseEvent.CLICK, onCanvasClick);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onCanvasMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onCanvasMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onCanvasMouseMove);
			
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
		
		private function drawTile(pos:Point, tile:Tile):void {
			MapEditor.self.tilePlaced(new Point(pos.x, pos.y), tile);
			var newTile:Tile = this.addChild(new Tile(tile.type)) as Tile;
			newTile.x = pos.x * Constants.TILE_WIDTH;
			newTile.y = pos.y * Constants.TILE_HEIGHT;
		}
		
		protected function onCanvasMouseMove(event:MouseEvent):void
		{
			var currentTile:Point = getTileOn(event);
			
			if (this.oldTile == null) {
				this.oldTile = currentTile;
				return;
			}
			
			if (currentTile.x != oldTile.x || currentTile.y != oldTile.y) {
				if (MapEditor.self.state == Constants.STATE_DRAWING) {
					var tile:Tile = MapEditor.self.selectedTile;
					if (currentTile.x < MapEditor.self.tileArray.length && currentTile.y < MapEditor.self.tileArray[0].length) {
						if (MapEditor.self.tileArray[currentTile.x][currentTile.y] == null && this.mouseIsDown) {
							drawTile(currentTile, tile);
						}
					}					
				}
			}
			
		}
		
		protected function onCanvasClick(event:MouseEvent):void
		{
			/*trace(event.currentTarget.toString());
			trace("canvas clicked in position x: " + MovieClip(event.currentTarget).mouseX + ", y: " + MovieClip(event.currentTarget).mouseY);
			trace("tile should be: tx: " + tileX + ", ty: " + tileY);*/
			
			var tileClicked:Point = getTileOn(event);
			
			if (MapEditor.self.state == Constants.STATE_DRAWING) {
				var tile:Tile = MapEditor.self.selectedTile;
				drawTile(tileClicked, tile);
			}
		}
		
		protected function onCanvasMouseDown(event:MouseEvent):void
		{
			/*var tileOn:Point = getTileOn(event);
			
			if (MapEditor.self.state == Constants.STATE_DRAWING) {
				var tile:Tile = MapEditor.self.selectedTile;
				if (MapEditor.self.tileArray[tileOn.x][tileOn.y] == null) {
					drawTile(tileOn, tile);
				}
			}*/
			this.mouseIsDown = true;
			trace("MOUSEDOWN");
			
		}
		
		protected function onCanvasMouseUp(event:MouseEvent):void {
			this.mouseIsDown = false;
		}
		
		private function getTileOn(evt:MouseEvent):Point
		{
			var mc:MovieClip = evt.currentTarget as MovieClip;
			var tileX:int = mc.mouseX / TILE_SIDE;
			var tileY:int = mc.mouseY / TILE_SIDE;
			
			return new Point(tileX, tileY);
		}
	}
}