package com
{
	import com.tiles.Tile;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[SWF(width='1024',height='768',backgroundColor='#ffffff',frameRate='25')]
	
	public class MapEditor extends Sprite
	{
		public static const appName:String = "Cenital Map Editor";
		
		public static var gui:Gui;
		public static var self:MapEditor;
		
		private var _state:int;
		private var _selectedTile:Tile;
		
		private var _tileArray:Array;
		
		public function MapEditor()
		{
			self = this;
			gui = new Gui();
			this.addChild(gui);
			
			this._state = Constants.STATE_IDLE;
			Tile.init();
			
			this._tileArray = new Array(Constants.MAP_TILE_WIDTH);
			for (var i:int = 0; i < _tileArray.length; i++)
			{
				_tileArray[i] = new Array(Constants.MAP_TILE_HEIGHT);
			}
		}

		public function placingTile(tile:Tile):void {
			this._selectedTile = this.addChild(tile) as Tile;
			this._state = Constants.STATE_DRAWING;
			moveCursor();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, moveCursor);
		}
		
		public function tilePlaced(pos:Point, tile:Tile):void {
			this._tileArray[pos.x][pos.y] = tile;
		}
		
		public function swapTile(tile:Tile):void 
		{
			this._state = Constants.STATE_DRAWING;
			this.removeChild(_selectedTile);
			this._selectedTile = this.addChild(tile) as Tile;
			moveCursor();
		}
		
		protected function moveCursor(event:MouseEvent=null):void
		{
			var globalPoint:Point = localToGlobal(new Point(mouseX, mouseY));
			
			_selectedTile.x = globalPoint.x - (_selectedTile.width / 2);
			_selectedTile.y = globalPoint.y - (_selectedTile.height / 2);
		}
		
		public function movingCanvas():void {
			this._state = Constants.STATE_MOVING_CANVAS;
		}
		
		public function canvasMoved():void {
			this._state = Constants.STATE_IDLE;
		}
		
		public function get selectedTile():Tile
		{
			return _selectedTile;
		}
		
		public function get state():int
		{
			return _state;
		}
		
		public function get tileArray():Array
		{
			return _tileArray;
		}
	}
}