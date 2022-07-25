package tools
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	
	
	public class Convertor
	{
		private var __target:Sprite;
		private var __mainXML:XML;
		private var __xml:XML;
		
		
		public function Convertor(targetClass:Class)
		{
			__target = new targetClass();
			
			__mainXML = <main></main>;
			
			parser(__target, __mainXML);	
			trace(__mainXML);
		}
		
		private function addAtributs(child:*, xml:XML, ...args):void
		{
			for (var i:int = 0; i < args.length; i++) 
			{
				var atribute:String = args[i]; xml.@[atribute] = child[atribute];	
			}		
		}
		
		private function parser(target:Sprite, parentXML:XML):void
		{
			for (var i:int = 0; i < target.numChildren; i++) 
			{	
				var child:* = target.getChildAt(i);
				
//				trace( target.getChildAt(i) );
				if(child is Sprite) //фильтруем Sprite
				{
					if(child.numChildren != 0)
					{
						var hasChild:Boolean = false;
						for (var j:int = 0; j < child.numChildren; j++) 
						{
							if(child.getChildAt(j) is Sprite)
							{
								hasChild = true; break;
							}
						}
						
						var xml:XML = <parent></parent>;
						
						if(hasChild) //фильтруем Container
						{
							var atribute:String = "class"; xml.@[atribute] = "starling.display.Sprite";
							
							addAtributs(child, xml, "width", "height", "name", "x" , "y", "scaleX", "scaleY");									
							parser(child, xml);
						}
						else //фильтруем Image
						{
							atribute = "class"; xml.@[atribute] = "display.SimpleImage";
							atribute = "texture"; xml.@[atribute] = getQualifiedClassName(child);
							
							addAtributs(child, xml, "width", "height", "name", "x" , "y", "scaleX", "scaleY");		
						}
					}
					
					parentXML.appendChild(xml);
				}
				else if(child is TextField)
				{
					xml = <parent></parent>;
					
					atribute = "class"; xml.@[atribute] = "display.text.SimpleTextField";
					atribute = "color"; xml.@[atribute] = (child as TextField).textColor;
					atribute = "fontSize"; xml.@[atribute] = (child as TextField).getTextFormat().size;
					atribute = "fontName"; xml.@[atribute] = (child as TextField).getTextFormat().font;
					
					addAtributs(child, xml, "width", "height", "text", "x" , "y", "scaleX", "scaleY", "name");	//если свойства совпадают				
					parentXML.appendChild(xml);
				}
				else if(child is SimpleButton)
				{
					xml = <parent></parent>;
					
					atribute = "class"; xml.@[atribute] = "starling.display.Button";
					atribute = "texture"; xml.@[atribute] = getQualifiedClassName(child);
					
					addAtributs(child, xml, "width", "height", "name", "x" , "y", "scaleX", "scaleY");
					parentXML.appendChild(xml);
				}
			}		
		}
	}
}