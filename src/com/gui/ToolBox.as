package com.gui
{
	import com.Constants;
	import com.MapEditor;
	import com.tiles.Tile;
	import com.tiles.TileParser;
	
	import fl.controls.Button;
	
	import flash.display.BlendMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;

	public class ToolBox extends ToolBoxMC
	{
		private static const V_PADDING:int = 5;
		
		private var buttons:Vector.<Button>;
		
		public function ToolBox()
		{
			super();
			
			buttons = new Vector.<Button>;
			
			addButton("Archivo", function(evt:MouseEvent):void {
				trace("Archivo clicked");
			}, true);
			
			addButton("Mover", function(evt:MouseEvent):void {
				moveCanvas();
			}, true);
			
			addButton("Nueva tile agua", function(evt:MouseEvent):void {
				placingTile(Constants.TILE_TYPE_WATER);
			}, true);
			
			addButton("Nueva tile tierra", function(evt:MouseEvent):void {
				placingTile(Constants.TILE_TYPE_LAND);
			}, true);
			
			addButton("Parse Tiles", function(evt:MouseEvent):void {
				parseTiles();
			}, true);
		}
		
		private function addButton(label:String, onClick:Function, enabled:Boolean):void
		{
			var but:fl.controls.Button = new Button();
			but.blendMode = BlendMode.NORMAL;
			var posBut:int = buttons.length;
			but.label = label;
			but.addEventListener(MouseEvent.CLICK, onClick);
			but.enabled = enabled;
			this.addChild(but);
			but.y = posBut * (but.height + V_PADDING);
			buttons.push(but);				
		}
		
		private function placingTile(tileType:int):void 
		{
			if (MapEditor.self.selectedTile == null) {
				MapEditor.self.placingTile(new Tile(tileType));
			} else {
				MapEditor.self.swapTile(new Tile(tileType));
			}
		}
		
		private function parseTiles():void 
		{
			var tp:TileParser = new TileParser();
		}
		
		private function moveCanvas():void {
			MapEditor.self.movingCanvas();
		}
	}
}