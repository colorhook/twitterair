package com.colorhook.twitterair.controller
{
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;
	
	public class RefreshPublicTimeLineCommand extends GetPublicTimeLineCommand
	{
		
		override public function execute():void{
			super.execute();
			CursorManager.setBusyCursor();
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("RefreshPublicTimeLineCommand onTweetrFault");
			super.onTweetrResult(event);
			CursorManager.removeBusyCursor();
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetPublicTimeLineCommand onTweetrFault");
			CursorManager.removeBusyCursor();
		}
		
	}
}