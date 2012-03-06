package com.gui
{
	import fl.controls.Button;
	
	import flash.events.MouseEvent;
	import com.MapEditor;

	public class MenuBar extends MenuBarMC
	{
		private var state:String;
		
		public function MenuBar()
		{
			super();
			
			this.state = "sin mapa";
			
			this.title.text = MapEditor.appName + " - " + state;
		}	
	}
}