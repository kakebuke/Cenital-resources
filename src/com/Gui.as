package com
{
	import com.gui.Canvas;
	import com.gui.MenuBar;
	import com.gui.ToolBox;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class Gui extends Sprite
	{
		private var menuBar:MenuBar;
		private var toolBox:ToolBox;
		private var canvas:Canvas;
		
		public function Gui()
		{
			this.menuBar = new MenuBar();
			this.menuBar.x = 0;
			this.menuBar.y = 0;
			this.addChild(menuBar);
			
			this.toolBox = new ToolBox();
			this.addChild(toolBox);
			this.toolBox.x = 1024 - this.toolBox.width;
			this.toolBox.y = this.menuBar.height - 5;
			this.toolBox.bg.height = 768;
			
			setCanvas();
			
			this.addChild(canvas);		
		}
		
		private function setCanvas():void
		{
			var viewPortWidth:int = 1024 - this.toolBox.width + 1;
			var viewPortHeight:int = 768 - this.menuBar.height +5;
			var viewPortRect:Rectangle = new Rectangle(0, 0, viewPortWidth, viewPortHeight);
			var canvasX:int = 0;
			var canvasY:int = this.toolBox.y;
			
			this.canvas = new Canvas(canvasX, canvasY, viewPortRect);
		}
	}
}