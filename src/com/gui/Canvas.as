package com.gui
{
	import com.Constants;
	import com.MapEditor;
	import com.tiles.Tile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	public class Canvas extends CanvasMC
	{
		private static const TILE_SIDE:int = 16;
		private var oldTile:Point;
		private var mouseIsDown:Boolean;
		private var oldPos:Point;
		private var tileLayer:Sprite;
		private var grid:MovieClip;
		
		public function Canvas(_x:int, _y:int, viewPortRect:Rectangle)
		{
			super();
			
			this.bg.width = Constants.MAP_TILE_WIDTH * Constants.TILE_WIDTH;
			this.bg.height = Constants.MAP_TILE_HEIGHT * Constants.TILE_HEIGHT;
			this.x = _x;
			this.y = _y;
			
			this.mouseIsDown = false;
			
			this.addEventListener(MouseEvent.CLICK, onCanvasClick);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onCanvasMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onCanvasMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onCanvasMouseMove);
			
			drawGrid();
			
			this.tileLayer = new Sprite();
			this.addChild(tileLayer);
			
			createViewPort(viewPortRect);			
		}
		
		private function createViewPort(viewPortRect:Rectangle):void
		{
			var mc:MovieClip = new MovieClip();
			mc.graphics.beginFill(0x000000);
			mc.graphics.drawRect(viewPortRect.x, viewPortRect.y, viewPortRect.width, viewPortRect.height);
			mc.graphics.endFill();
			this.addChild(mc);
			this.mask = mc;			
		}
		
		private function drawGrid():void
		{
			var mc:MovieClip = new MovieClip();
			var lx:int = 0;
			var ly:int = 0;
			
			mc.graphics.lineStyle(1, 0xffffff, 1);
			while (lx < this.width) {
				mc.graphics.moveTo(lx,0);
				mc.graphics.lineTo(lx, this.bg.height);
				lx += TILE_SIDE;
			}
			while (ly < this.height) {
				mc.graphics.moveTo(0, ly);
				mc.graphics.lineTo(this.bg.width, ly);
				ly += TILE_SIDE;
			}
			this.grid = this.addChild(mc) as MovieClip;
		}
		
		protected function onCanvasMouseMove(event:MouseEvent):void
		{
			switch (MapEditor.self.state) {
				case Constants.STATE_DRAWING:
					onCanvasMouseMoveDrawing(event);
					break;
				case Constants.STATE_MOVING_CANVAS:
					onCanvasMouseMoveDragging(event);
					break;
			}			
		}
		
		private function onCanvasMouseMoveDragging(e:MouseEvent):void
		{
			if (this.mouseIsDown) {
				var despl:Point = new Point();
				var pos:Point = new Point(MovieClip(e.currentTarget).mouseX, MovieClip(e.currentTarget).mouseY);
				
				if (oldPos == null) {				
					oldPos = pos;
				}
				
				despl.x = oldPos.x - pos.x;
				despl.y = oldPos.y - pos.y;
				
				//trace(despl.toString());				
				
				this.tileLayer.x -= despl.x;
				this.tileLayer.y -= despl.y;
				this.grid.x -= despl.x;
				this.grid.y -= despl.y;
				
				oldPos = pos;
			}
		}
		
		private function onCanvasMouseMoveDrawing(event:MouseEvent):void {
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
							trace(currentTile.toString());
						}
					}					
				}
			}
		}
		
		private function drawTile(pos:Point, tile:Tile):void {
			MapEditor.self.tilePlaced(new Point(pos.x, pos.y), tile);
			var newTile:Tile = this.tileLayer.addChild(new Tile(tile.type)) as Tile;
			newTile.x = pos.x * Constants.TILE_WIDTH;
			newTile.y = pos.y * Constants.TILE_HEIGHT;
		}
		
		protected function onCanvasClick(event:MouseEvent):void
		{
			var tileClicked:Point = getTileOn(event);
			
			if (MapEditor.self.state == Constants.STATE_DRAWING) {
				var tile:Tile = MapEditor.self.selectedTile;
				drawTile(tileClicked, tile);
				trace(tileClicked.toString());
			}
		}
		
		protected function onCanvasMouseDown(event:MouseEvent):void
		{
			this.mouseIsDown = true;
		}
		
		protected function onCanvasMouseUp(event:MouseEvent):void {
			this.mouseIsDown = false;
			this.oldPos = null;
		}
		
		private function getTileOn(evt:MouseEvent):Point
		{
			var mc:MovieClip = evt.currentTarget as MovieClip;
			var tileX:int = (mc.mouseX / TILE_SIDE) - (grid.x / TILE_SIDE);
			var tileY:int = (mc.mouseY / TILE_SIDE) - (grid.y / TILE_SIDE);			
			
			var p:Point = new Point(tileX, tileY); 
		
			return p;
		}
	}
}