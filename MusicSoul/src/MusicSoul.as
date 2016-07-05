package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	
	import vk.APIConnection;
	import vk.events.*;
	import vk.ui.VKButton;
	
	/**
	 * ...
	 * @author unname
	 */
	public class MusicSoul extends Sprite
	{
		
		public function MusicSoul()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			if(e)
				removeEventListener(e.type, init);
				
			// Form Creating

		}
	
	}

}