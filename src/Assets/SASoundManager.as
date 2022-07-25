package Assets
{
	import treefortress.sound.SoundManager;

	public class SASoundManager
	{
		static public const STAY_PART:String = "STAY_PART";
		static public const RIGHT:String = "RIGHT";
		static public const GET_FRUIT:String = "GET_FRUIT";
		static public const BUTTON_TAP:String = "BUTTON_TAP";
	
		static public var FX:String = "fx";
		static public var MUSIC:String = "music";
		
		static private var music_group:SoundManager;
		static private var fx_group:SoundManager;
		
		static public function loadSounds():void
		{
			music_group = new SoundManager();		
			fx_group = new SoundManager();
			
				
//			addFx("uploads/Sounds/stay_part.mp3", STAY_PART);
//			addFx("uploads/Sounds/right.mp3", RIGHT);
//			addFx("uploads/Sounds/get_fruit.mp3", GET_FRUIT);
//			addFx("uploads/Sounds/buttons_UI.mp3", BUTTON_TAP);
			
			setSoundOnStart();
		}
		
		private static function setSoundOnStart():void
		{
//			mute( MUSIC, mainData.instance.settings.sound[MainDataType.MUSIC_MUTE] );
//			mute( FX, mainData.instance.settings.sound[MainDataType.FX_MUTE] );
		}
		
		// add sound
		static private function addFx(url:String, name:String):void
		{
			fx_group.loadSound( Connections.STATIC_PATH + url, name );
		}
		
		static private function addMusic(url:String, name:String):void
		{
			music_group.loadSound( Connections.STATIC_PATH + url, name );
		}
		
		//mute
		static public function off(type:String):void
		{
			mute(type, true);
		}
		
		static public function on(type:String):void
		{
			mute(type, false);
		}
		
		static private function mute(type:String, mute:Boolean):void
		{
			switch(type)
			{
				case FX:
					fx_group.mute = mute;
					break;
				case MUSIC:
					music_group.mute = mute;
					break;
			}
		}
		
		//play
		static public function playMusic(name:String, volume:Number):void
		{
			music_group.playLoop( name, volume );
		}
		
		static public function playFX(name:String, volume:Number):void
		{
			fx_group.playFx( name, volume );
		}
		
		//pause
		static public function stopMusic(name:String):void
		{
			music_group.getSound( name ).stop();
		}
		
		static public function stopFx(name:String):void
		{
			fx_group.getSound( name ).stop();
		}
		
		static public function getFxMute():Boolean
		{
			return fx_group.mute;
		}
		
		static public function getMusicMute():Boolean
		{
			return music_group.mute;
		}
	}
}