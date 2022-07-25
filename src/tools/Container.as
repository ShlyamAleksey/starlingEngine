package tools
{
	import display.SimpleImage;
	import display.SimpleShape;
	import display.SimpleSprite;
	import display.text.SimpleTextField;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Container extends SimpleSprite
	{
		protected var data:XML;
		
		public function Container()
		{
			super();
		}
		
		override protected function init(e:Event = null):void
		{
			SimpleShape
			SimpleImage
			SimpleTextField
			
			/*var xml:XML = <example class="first" />
			trace(xml.attribute("class"));*/
			
			super.init(e);
			createParent(data.parent, this);
		}
		
		private function createParent(list:XMLList, parent:DisplayObjectContainer):void
		{
			for (var i:int = 0; i < list.length(); i++) 
			{			
				var className:String = list[i].attributes()[0];
				
				switch(className)
				{
					case "display.SimpleImage":
						//trace(list[i].attributes()[1]);
						var texture:Texture = assets.getTexture(list[i].attributes()[1]);
						target = new SimpleImage( texture );
						parent.addChild(target);
						//(parent as SimpleSprite)[target["name"]]
						break;
					
					case "display.text.SimpleTextField":
						target = new SimpleTextField(list[i].attributes()[1], list[i].attributes()[2], list[i].attributes()[3]);
						parent.addChild(target);
						break;
					
					case "starling.display.Button":
						target = new Button( 	assets.getTexture(list[i].attributes()[1] + "_up"), "",
												assets.getTexture(list[i].attributes()[1] + "_down"),
												assets.getTexture(list[i].attributes()[1] + "_over"));
						parent.addChild(target);
						break;
					
					default:
						var targetClass:Class = StarlingManager.definition( className );
						var target:* = new targetClass();
						parent.addChild(target);
						break;
				}
				
				if(list[i].parent.attributes().length() != 0) createParent(list[i].parent, target);
				
				for each (var atribute:* in list[i].attributes()) 
				{
					var property:String = atribute.name();
					try
					{
						target[property] = atribute;
					} 
					catch(error:Error){}	
				}
			}
		}
		
		override protected function onResize(e:Event):void{}
		
		override protected function destroy(e:Event):void
		{
			super.destroy(e);
		}
	}
}