package tools
{
	import starling.display.Stage;
	import starling.events.Event;
	
	public function stageRender(stage:Stage, callBack:Function, data:Object = null):void
	{
		stage.addEventListener(Event.ENTER_FRAME, update);
		var count:uint = 0;
		
		function update(e:Event):void
		{
			count++;
			if(count == 2)
			{
				if(data) callBack(data);
				else callBack();
				stage.removeEventListener(Event.ENTER_FRAME, update);
			}		
		} 
	}
} 