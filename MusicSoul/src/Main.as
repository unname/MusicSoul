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
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}