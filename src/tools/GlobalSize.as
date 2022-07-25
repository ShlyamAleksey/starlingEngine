package tools
{
	import starling.display.DisplayObject;

	public class GlobalSize
	{
		public function GlobalSize()
		{
		}
		
		static public function widht(child:DisplayObject):Number
		{
			var totalScale:Number = 1;
			scale(child.parent);
			
			function scale(target:DisplayObject):Number
			{
				if(target && target.scaleX)
				{
					totalScale *= target.scaleX;
					scale(target.parent)
					return target.scaleX;
				}
				else return 0;
			}

			return totalScale*child.width;
		}
		
		static public function height(child:DisplayObject):Number
		{
			var totalScale:Number = 1
			scale(child.parent);

			function scale(target:DisplayObject):Number
			{
				if(target && target.scaleY)
				{
					totalScale *= target.scaleY;
					scale(target.parent)
					return target.scaleY;
				}
				else return 0;
			}
			
			return totalScale*child.height;
		}
	}
}