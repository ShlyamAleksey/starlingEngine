package tools
{
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class BoundViewer
	{
		private var __target:DisplayObject;
		private var __boundArea:Quad;
		
		public function BoundViewer(parent:Sprite, target:DisplayObject, color:uint = 0xff0000)
		{
			__target = target;
			
			__boundArea = new Quad(1, 1, color);
			__boundArea.alpha = 0.25;
			parent.addChild( __boundArea ); __boundArea.touchable = false;
		}
		
		
		public function set showBound(value:Boolean):void
		{
			__boundArea.visible = value;
		}
		
		public function clear():void
		{
			__boundArea.parent.removeChild( __boundArea );
		}
		
		
		public function render():void
		{
			__boundArea.width = __target.width;
			__boundArea.height = __target.height;
			__boundArea.x = __target.bounds.topLeft.x;
			__boundArea.y = __target.bounds.topLeft.y;
		}
	}
}