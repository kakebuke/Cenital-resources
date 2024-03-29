package com
{
	public class Constants
	{
		public static const TILE_WIDTH			:int = 16;
		public static const TILE_HEIGHT			:int = 16;
		
		public static const STATE_IDLE			:uint = 0;
		public static const STATE_DRAWING		:uint = 1;
		public static const STATE_MOVING_CANVAS	:uint = 2;
		
		public static const FILE_TILES:String 	= "mapTiles.png";	
		
		public static const TILE_TYPE_LAND		:uint = 0;
		public static const TILE_TYPE_WATER		:uint = 1;
		
		public static const MAP_TILE_WIDTH		:uint = 100;
		public static const MAP_TILE_HEIGHT		:uint = 100;
		
		public function Constants()
		{
		}
	}
}