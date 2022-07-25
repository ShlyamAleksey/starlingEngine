package console
{
	public function console(...params):void
	{
		var text:String = "";
		for (var i:int = 0; i < params.length; i++) 
		{
			text = text + " " + params[i]
		}
		ConsoleAssets.assets.text = ConsoleAssets.assets.text + "\n" + text;	
		ConsoleAssets.assets.scrollV = ConsoleAssets.assets.numLines;
		trace(text);
	}
}