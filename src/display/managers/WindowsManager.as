package display.managers
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class WindowsManager extends Sprite
	{
		static private var _winStack:Vector.<Sprite>;
		static private var __backGround:Sprite;
		static private var __currentWin:*;
		static public var windowStack:Array = new Array();
		static public var AMOUNT:int = 0; 
		static private var _isView:Boolean = false;
		
		static private var __touchable:Boolean;
		static private var __backAlpha:Number = 0.7;
		static private var __quad:Quad;
		static public var mainSprite:Sprite;
		
		public static function get isView():Boolean
		{
			return _isView;
		}

		public static function set isView(value:Boolean):void
		{
			_isView = value;
		}

		static private var __onAllWindowCloseFunction:Function;
		static private var __onAllWindowCloseParams:Array;
		static private var __onAllWindowCloseTarget:Object;
		
		
		public function WindowsManager()
		{
			
		}
		
		static public function addListeners():void
		{
			mainSprite.stage.addEventListener( Event.RESIZE, onResize);
		}
		
		static public function removeListeners():void
		{
			mainSprite.stage.removeEventListener( Event.RESIZE, onResize);		
		}
		
		static private function onResize():void
		{
			if(__backGround)
			{
				__quad.width = mainSprite.stage.stageWidth;
				__quad.height = mainSprite.stage.stageHeight;
			}
		}
		
		public static function get backAlpha():Number
		{
			return __backAlpha;
		}

		public static function set backAlpha(value:Number):void
		{
			__backAlpha = value;
			if(__backGround && __backGround.getChildByName("back")) __backGround.getChildByName("back").alpha = __backAlpha
		}

		private static function touchable(o:Object):void
		{
			__backGround.touchable = o["touchable"];
			__currentWin.touchable = o["touchable"];
		}

		static public function show(winClass:Class,... params):void
		{
			if(!isView) showCurrentWindow(winClass, params);
			else windowStack.push( {"window" : winClass, "params" : params} );

		}
		
		private static function showCurrentWindow(winClass:Class, params:*):void
		{	
			isView = true;
			
			if(params.length) __currentWin =  new winClass(params);
			else __currentWin = new winClass();
			
			createBackGround();
			__backGround.addChild( __currentWin );
			animate(__currentWin);
			
			if(params.length && (params[params.length - 1] != null ) && params[params.length - 1].hasOwnProperty("touchable"))
			{
				touchable(params[params.length - 1]);
			}
		}
		
		static private function animate(spr:Sprite):void
		{			
			spr.x = mainSprite.stage.stageWidth >> 1 ;
			spr.y = mainSprite.stage.stageHeight >> 1;

			TweenLite.from(spr, 1, { alpha:0, scaleX:0.3, scaleY:0.3, ease:Back.easeOut } );
		}
		
		static public function hide(fun:Function = null):void
		{
			if(__currentWin == null){ workingCall(); return; }
			TweenMax.to(__currentWin, .45, { alpha:0, scaleX:0.3, scaleY:0.3, ease:Back.easeOut, onComplete:completeHidingWindow});
			
			function completeHidingWindow():void
			{
				AMOUNT++;
				if(!isView){
					workingCall();
					return;
				}

				__backGround.removeChild( __currentWin );
				mainSprite.removeChild(__backGround);
				
				isView = false;
				__currentWin = null;
				__backGround = null;
				
				if(windowStack.length)
				{
					showCurrentWindow(windowStack[0]["window"], windowStack[0]["params"]);
					windowStack.shift();
				}
				else
				{
					if(__onAllWindowCloseFunction != null)
					{
						__onAllWindowCloseFunction.apply(__onAllWindowCloseTarget, __onAllWindowCloseParams); 
						__onAllWindowCloseFunction = null;
					}
				}
				workingCall();
			}
			
			function workingCall():void
			{
            	if(fun) fun.call();
			}
		}
		
		static public function onAllwindowClose(target:Object, fun:Function, params:Object):void
		{
			__onAllWindowCloseFunction = fun;
			__onAllWindowCloseParams = [params];
			__onAllWindowCloseTarget = target;
		}
		
		static private function createBackGround():void
		{
			__backGround = new Sprite();
				__quad = new Quad(mainSprite.stage.stageWidth, mainSprite.stage.stageHeight); 
				__quad.color = 0x000000;
				__quad.alpha = __backAlpha;
				__quad.name = "back"
				__backGround.addChild( __quad );
				mainSprite.addChild(__backGround);
		}		
	}
}