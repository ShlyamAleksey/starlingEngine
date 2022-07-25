package display.button
{
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import display.SimpleTextFormat;
	import display.UIConstant;
	
	public class TextButton extends SimpleButton
	{
		private var __label:String;
		private var __textFormat:SimpleTextFormat;
		private var __labelField:TextField
		
		public function TextButton(texture:Texture, onTriggered:Function, label:String = 'Button', textFormat:SimpleTextFormat = null)
		{
			__label = label;
			
			if(textFormat) __textFormat = textFormat;
			else __textFormat = new SimpleTextFormat();
				
			super(texture, onTriggered);
		}
		
		override protected function init(e:Event=null):void
		{
			super.init(e);
			createLabel();
		}
		
		private function createLabel():void
		{
			var size:Number = this.fontSize;
			__labelField = new TextField( 	this.width, this.height, __label,
														__textFormat.fontName, __textFormat.fontSize,
														__textFormat.color);
			addChild( __labelField ); __labelField.touchable = false;
		}
		
		private function get fontSize():Number
		{
			var size:int = this.height*UIConstant.ADOBE_PUNKT;
			return size;
		}
		
		override protected function destroy(e:Event):void
		{
			super.destroy(e);
			__labelField.dispose();
		}
	}
}