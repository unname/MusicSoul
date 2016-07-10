package
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.text.*;
	import flash.net.URLRequest
	
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
		
		private var MyInformation:Object;
		private var UserInformation:Object;
			
		private var MyMusicList:Vector.<String>;
		private var UserMusicList:Vector.<String>;
		
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
			trace("Error: "+data.error_msg+"\n");
		}
		
		
		private function PrintMyMusic(event:Event): void
		{
			// Example of fetching fail from API request
			//tf.appendText("\n\tGet music - OK !\n");
		}
		
		private function PrintMyInformation(event:Event): void
		{
			var my_image_loader:Loader = new Loader();
			
			my_image_loader.x = 65;
			my_image_loader.y = 50;
			
			my_image_loader.load(new URLRequest(MyInformation[0]['photo_100']));
			
			addChild(my_image_loader);
		}
		
		private function GetInformation(id:int):void
		{		
			VK.api('users.get', {user_ids: id, fields:'city, photo_100'}, function(data:Object):void
			{				
				if (id == flashVars['viewer_id'])
				{
					MyInformation = data;
					dispatchEvent(new Event("MyInformationLoaded"));
				}
				else
				{
					UserInformation = new Vector.<String>();
					UserInformation = data;
					dispatchEvent(new Event("UserInformationLoaded"));
				}
			}
			, onApiRequestFail);
		}
		
		private function GetMusicList(id:int, count:int):void
		{		
			VK.api('audio.get', {owner_id: id, count:count}, function(data:Object):void
			{	
				var i:int;
				
				if (id == flashVars['viewer_id'])
				{
					for (i = 1; i <= count; ++i)
						MyMusicList.push(data[i]['artist']);
						
					dispatchEvent(new Event("MyMusicLoaded"));
				}
				else
				{
					UserMusicList = new Vector.<String>();
					
					for (i = 1; i <= count; ++i)
						UserMusicList.push(data[i]['artist']);
						
					dispatchEvent(new Event("UserMusicLoaded"));
				}
			}
			, onApiRequestFail);
		}
				
		private function init(e:Event = null):void
		{
			if(e)
				removeEventListener(e.type, init);	

			flashVars = stage.loaderInfo.parameters as Object;
			
			// -- Code for local testing:
			if (!flashVars.api_id)
			{
				flashVars['api_id'] 	= 5535414;
				flashVars['viewer_id'] 	= 3272722;
				flashVars['sid']		= "00582dbd60652d1b10ca7e0732d03552cc704ceacb11284ee8184f559042ed16d9b4c0642db1d8183c4de";
				flashVars['secret'] 	= "82e2b5752e";
			}
			
			VK 				= new APIConnection(flashVars);
			MyMusicList 	= new Vector.<String>();
			MyInformation 	= new Object();
			
			addEventListener("MyInformationLoaded", PrintMyInformation);
			addEventListener("MyMusicLoaded", PrintMyMusic);
			
			GetInformation(flashVars['viewer_id']);
			GetMusicList(flashVars['viewer_id'], 10);
		}
	}
}