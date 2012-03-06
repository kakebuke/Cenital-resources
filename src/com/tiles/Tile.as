package com.tiles
{
	import com.Constants;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	public class Tile extends MovieClip
	{
		private static var bitmapTiles:BitmapData;
		private static var tileBitmaps:Array;
		
		private var _type:int;
		
		public function Tile(tileType:int)
		{
			super();
			
			this._type = tileType;
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			var bmp:Bitmap = new Bitmap(tileBitmaps[_type]);
			bmp.width = Constants.TILE_WIDTH;
			bmp.height = Constants.TILE_HEIGHT;
			
			addChild(bmp);
		}
		
		public static function init():void {
			var request:URLRequest = new URLRequest("assets/" + Constants.FILE_TILES);
			var loader:Loader = new Loader();
			loader.load(request);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
		}
		
		protected static function onIoError(event:IOErrorEvent):void
		{
			trace("ERROR LOADING FILE_TILES");			
		}
		
		protected static function onLoadComplete(event:Event):void
		{
			tileBitmaps = [];
			var bmp:Bitmap = LoaderInfo(event.currentTarget).content as Bitmap;
			bitmapTiles = bmp.bitmapData;
			var tbd:BitmapData;
			for (var i:int = 0, pos:int = 0; pos < bmp.width; pos += Constants.TILE_WIDTH, i++) {
				tbd = new BitmapData(32, 32);
				tbd.copyPixels(bitmapTiles, new Rectangle(i * 32, 0, 32, 32), new Point());
				tileBitmaps.push(tbd);
			}
			trace("LOADED");
		}
		
		public function get type():int
		{
			return _type;
		}
		
	}
}