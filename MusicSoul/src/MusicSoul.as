package
{
	import flash.display.Sprite;
	import flash.text.*;
	
	import flash.events.Event;
	import flash.events.DataEvent;
	
	import vk.APIConnection;
	import vk.events.*;
	import vk.ui.VKButton;
	import vk.api.*;
	
	/**
	 * ...
	 * @author unname
	 */
	public class MusicSoul extends Sprite
	{
		private var flashVars: Object;
		private var VK: APIConnection;
		
		private var tf: TextField;
		
		private var MyMysic:Vector.<String>  = new Vector.<String>();
		
		public function MusicSoul()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function onApiRequestFail(data: Object): void
		{
			// Example of fetching fail from API request
			tf.appendText("Error: "+data.error_msg+"\n");
		}
		
		
		private function PrintMyMusic(event:Event): void
		{
			// Example of fetching fail from API request
			tf.appendText("\n\tget data - OK !\n");
		}
		
		private function GetMusicList(id:int, count:int):void
		{		
			VK.api('audio.get', {owner_id: id, count:count}, function(data:Object):void
			{		
				for (var i:int = 1; i <= count; ++i)
				{
					tf.appendText(data[i]['artist'] + "\n");
					MyMysic.push(data[i]['artist']);
				}
				
				if(id == flashVars['viewer_id'])
					dispatchEvent(new Event("MyMusicLoaded"));
			}
			, onApiRequestFail);
		}
		
		private function init(e:Event = null):void
		{
			if(e)
				removeEventListener(e.type, init);
			
			// ----- / ----- / ----- / ----- /
			// 		    Form Creating
			// ----- / ----- / ----- / ----- /
			
			tf = new TextField();
			tf.x = 10;
			tf.y = 50;
			tf.width = 587;
			tf.height = 349;
			
			tf.border = true;
			tf.borderColor = 0xDAE2E8;
			tf.background = true;
			tf.backgroundColor = 0xFFFFFF;
			tf.embedFonts = false;
			var format:TextFormat = new TextFormat();
			format.font = "Tahoma";
			format.color = 0x000000;
			format.size = 11;
			tf.defaultTextFormat = format;
			addChild(tf);
			tf.appendText("Application initialized\n\n");
				
			//vk parameters
			flashVars = stage.loaderInfo.parameters as Object;
			if (flashVars.api_id) {
				tf.appendText("\n// -- Your code for local testing:\n");
				tf.appendText("flashVars['api_id'] = " + flashVars['api_id'] + ";\n");
				tf.appendText("flashVars['viewer_id'] = " + flashVars['viewer_id'] + ";\n");
				tf.appendText("flashVars['sid'] = \"" + flashVars['sid'] + "\";\n");
				tf.appendText("flashVars['secret'] = \"" + flashVars['secret'] + "\";\n");
				tf.appendText("// -- //\n\n");
			}
			// -- Code for local testing:
			if (!flashVars.api_id)
			{
				flashVars['api_id'] = 5535414;
				flashVars['viewer_id'] = 3272722;
				flashVars['sid'] = "00582dbd60652d1b10ca7e0732d03552cc704ceacb11284ee8184f559042ed16d9b4c0642db1d8183c4de";
				flashVars['secret'] = "82e2b5752e";
			}
			
			VK = new APIConnection(flashVars);
					
			addEventListener("MyMusicLoaded", PrintMyMusic);
			
			GetMusicList(flashVars['viewer_id'], 3);
			
			//VK.api('getProfiles', { uids: flashVars['viewer_id'] }, fetchUserInfo, onApiRequestFail);
			//VK.api('audio.get', {owner_id: flashVars['viewer_id'] , count:3}, fetchUserInfo, onApiRequestFail);
		}
	}
}