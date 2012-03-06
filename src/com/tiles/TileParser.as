package com.tiles
{
	import com.Constants;
	import com.MapEditor;

	public class TileParser
	{
		public function TileParser()
		{
			var tileArray:Array = MapEditor.self.tileArray;
			var parsedMap:String = "[";
			for (var i:int = 0; i < tileArray.length; i++) {
				parsedMap += "[";
				for (var j:int = 0; j < tileArray[i].length; j++) {
					if (tileArray[i][j] == null) {
						parsedMap += Constants.TILE_TYPE_WATER + ",";
					} else {
						parsedMap += Tile(tileArray[i][j]).type + ",";
					}
				}
				parsedMap = parsedMap.substring(0, parsedMap.length - 1);
				parsedMap += "],";
			}
			parsedMap = parsedMap.substring(0, parsedMap.length - 1);
			parsedMap += "]";
			
			trace(parsedMap);
		}
	}
}