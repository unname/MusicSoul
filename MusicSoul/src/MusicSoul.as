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
			
			// ----- / ----- / ----- / ----- /
			// 		    Form Creating
			// ----- / ----- / ----- / ----- /
			

				
			//vk parameters
			var flashVars: Object = stage.loaderInfo.parameters as Object;

			// -- Code for local testing:
			if (!flashVars.api_id)
			{
				flashVars['api_id'] = 5535414;
				flashVars['viewer_id'] = 3272722;
				flashVars['sid'] = "1ab3f99bff0638f363fa92dc8cb3a19ce2e30164ed376389d301ca853197593331152ab17da2a1ad5d2a8";
				flashVars['secret'] = "5fb0d87ab7";
			}
			
			var VK: APIConnection = new APIConnection(flashVars);
			
			// Example of API request
			//VK.api('getProfiles', { uids: flashVars['viewer_id'] }, fetchUserInfo, onApiRequestFail);
		}
	
	}

}