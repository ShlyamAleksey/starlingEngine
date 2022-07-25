package console
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class ConsoleAssets extends Sprite
	{
		private var __style:String;
		static public var DARK_BLUE:String = "DARK_BLUE";
		static public var NIGHT:String = "NIGHT";
		
		static private var __init:ConsoleAssets
		
		private var __consoleUI:ConsoleUI;
		private var version:String = "SA Engine version 1.0.6";
		static private var consoleTF:TextField;
		static private var inputTF:TextField;
		static public var __command:ICommand;
		
		
		static public function get instance():ConsoleAssets
		{
			if(!__init) __init = new ConsoleAssets();
			return __init;
		}

		public function ConsoleAssets()
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addLog();
			addInput();
			style = DARK_BLUE;
			new ConsoleUI(stage);
			
			this.visible = false;
			this.alpha = 0.97;
		}
		
		private function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);	
		}
		
		static public function set command(c:Class):void
		{
			__command = new c();
		}
		
		public function execute():void
		{
			__command.execute(inputTF.text);
			inputTF.text = "";
		}
		
		static public function set style(value:String):void
		{
			switch(value)
			{
				case DARK_BLUE:
					consoleTF.borderColor = 0x2D3842;
					consoleTF.backgroundColor = 0x35424D;
					consoleTF.textColor = 0x799E0A;
					inputTF.borderColor = 0x2D3842;
					inputTF.backgroundColor = 0x35424D;
					inputTF.textColor = 0x799E0A;
					break;
				case NIGHT:
					consoleTF.borderColor = 0x000000;
					consoleTF.backgroundColor = 0x111111;
					consoleTF.textColor = 0x9F5400;
					inputTF.borderColor = 0x000000;
					inputTF.backgroundColor = 0x111111;
					inputTF.textColor = 0x9F5400;
					break;
			}
		}
		
		private function addLog():void
		{
			consoleTF = new TextField();
			consoleTF.text = version;
			consoleTF.width = 300;
			consoleTF.height = 400;
			consoleTF.type = TextFieldType.DYNAMIC;
			consoleTF.border = true;
			consoleTF.background = true;
			
			addChild( consoleTF);
		}
		
		private function addInput():void
		{
			inputTF = new TextField();
			inputTF.type = TextFieldType.INPUT;
			inputTF.width = 300;
			inputTF.height = 20;
			inputTF.border = true;
			inputTF.background = true;
			inputTF.y = 400;
			addChild( inputTF);
		}
		
		public function showLog():void
		{
			this.visible = true;
			TweenLite.to(this, 0.5, { alpha : 1 })
		}
		
		public function hideLog():void
		{
			TweenLite.to(this, 0.5, { alpha : 0, onComplete: hide })
			
		}
		
		private function hide():void 
		{
			this.visible = false;
		}
		
		static public function get assets():TextField
		{
			return consoleTF;
		}
	}
}