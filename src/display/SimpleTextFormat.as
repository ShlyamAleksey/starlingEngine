package display
{
	public class SimpleTextFormat
	{
		private var __color:uint = 0x00;
		private var __fontName:String = 'Verdana';
		private var __fontsize:int = 12;

		public function get fontSize():int
		{
			return __fontsize;
		}

		public function set fontSize(value:int):void
		{
			__fontsize = value;
		}

		public function get fontName():String
		{
			return __fontName;
		}

		public function set fontName(value:String):void
		{
			__fontName = value;
		}

		public function get color():uint
		{
			return __color;
		}

		public function set color(value:uint):void
		{
			__color = value;
		}

	}
}