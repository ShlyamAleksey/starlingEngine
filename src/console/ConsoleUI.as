package console
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class ConsoleUI extends Sprite
	{
		private var __isShow:Boolean = false;
		private var __pressTilde:Boolean = false;
		private var __pressEnter:Boolean = false;
		
		public function ConsoleUI(stage:Stage)
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function get isShow():Boolean
		{
			return __isShow;
		}
		
		public function set isShow(value:Boolean):void
		{
			__isShow = value;
			
			if(__isShow) ConsoleAssets.instance.hideLog();
			else ConsoleAssets.instance.showLog();
		}
		
		private function showConsole():void
		{
			if(isShow) isShow = false;
			else isShow = true;
		}
		
		protected function onKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == 192) __pressTilde = false;	
			if(e.keyCode == 13) __pressEnter = false;
		}
		
		protected function onKeyDown(e:KeyboardEvent):void
		{	
			if(e.keyCode == 192 && !__pressTilde)
			{
				__pressTilde = true;
				showConsole();
			}
			
			if(e.keyCode == 13 && !__pressEnter)
			{
				__pressEnter = true;
				execute();
			}
		}
		
		private function execute():void
		{
			ConsoleAssets.instance.execute();
		}
	}
}